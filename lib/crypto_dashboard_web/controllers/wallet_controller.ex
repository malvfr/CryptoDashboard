defmodule CryptoDashboardWeb.WalletController do
  use CryptoDashboardWeb, :controller

  alias CryptoDashboard.Portfolio
  alias CryptoDashboard.Portfolio.Wallet

  def index(conn, _params) do
    wallets = Portfolio.list_wallets(conn.assigns[:user].id)
    render(conn, "index.html", wallets: wallets)
  end

  def new(conn, _params) do
    changeset = Portfolio.change_wallet(%Wallet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wallet" => wallet_params}) do
    wallet_params = Map.put(wallet_params, "user_id", conn.assigns[:user].id)

    case Portfolio.create_wallet(wallet_params) do
      {:ok, wallet} ->
        conn
        |> put_flash(:info, "Wallet created successfully.")
        |> redirect(to: Routes.wallet_path(conn, :show, wallet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wallet = Portfolio.get_wallet!(id)
    conn = assign(conn, :wallet, wallet)
    render(conn, "show.html", wallet: wallet)
  end

  def edit(conn, %{"id" => id}) do
    wallet = Portfolio.get_wallet!(id)
    changeset = Portfolio.change_wallet(wallet)
    render(conn, "edit.html", wallet: wallet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wallet" => wallet_params}) do
    wallet = Portfolio.get_wallet!(id)

    case Portfolio.update_wallet(wallet, wallet_params) do
      {:ok, wallet} ->
        conn
        |> put_flash(:info, "Wallet updated successfully.")
        |> redirect(to: Routes.wallet_path(conn, :show, wallet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", wallet: wallet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wallet = Portfolio.get_wallet!(id)
    {:ok, _wallet} = Portfolio.delete_wallet(wallet)

    conn
    |> put_flash(:info, "Wallet deleted successfully.")
    |> redirect(to: Routes.wallet_path(conn, :index))
  end
end
