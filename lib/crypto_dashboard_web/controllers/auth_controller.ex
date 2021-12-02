defmodule CryptoDashboardWeb.AuthController do
  use CryptoDashboardWeb, :controller
  plug Ueberauth

  alias CryptoDashboard.Models.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: CryptoDashboardWeb.Router.Helpers.page_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> redirect(to: CryptoDashboardWeb.Router.Helpers.page_path(conn, :home))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: CryptoDashboardWeb.Router.Helpers.page_path(conn, :index))
    end
  end

  def insert_or_update_user(changeset) do
    case CryptoDashboard.Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        CryptoDashboard.Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end
end
