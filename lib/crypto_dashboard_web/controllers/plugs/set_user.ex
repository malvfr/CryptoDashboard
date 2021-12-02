defmodule CryptoDashboardWeb.Plugs.SetUser do
  import Plug.Conn

  alias CryptoDashboard.Repo
  alias CryptoDashboard.Models.User
  alias CryptoDashboard.Portfolio

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    conn =
      cond do
        user = user_id && Repo.get(User, user_id) ->
          wallets = Portfolio.list_wallets(user.id)
          conn = assign(conn, :user, user)
          assign(conn, :wallets, wallets)

        true ->
          assign(conn, :user, nil)
      end

    wallet_id = get_session(conn, :wallet_id)

    cond do
      wallet = wallet_id && Portfolio.get_wallet(wallet_id) ->
        assign(conn, :wallet, wallet)

      true ->
        conn
    end
  end
end
