defmodule CryptoDashboardWeb.WalletControllerTest do
  use CryptoDashboardWeb.ConnCase

  import CryptoDashboard.PortfolioFixtures
  alias CryptoDashboard.Models.User

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "new wallet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.wallet_path(conn, :new))
      assert html_response(conn, 200) =~ "New Wallet"
    end
  end

  describe "edit wallet" do
    setup [:create_wallet]

    test "renders form for editing chosen wallet", %{conn: conn, wallet: wallet} do
      conn = get(conn, Routes.wallet_path(conn, :edit, wallet))
      assert html_response(conn, 200) =~ "Edit Wallet"
    end
  end

  describe "update wallet" do
    setup [:create_wallet]

    test "redirects when data is valid", %{conn: conn, wallet: wallet} do
      conn = put(conn, Routes.wallet_path(conn, :update, wallet), wallet: @update_attrs)
      assert redirected_to(conn) == Routes.wallet_path(conn, :show, wallet)

      conn = get(conn, Routes.wallet_path(conn, :show, wallet))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, wallet: wallet} do
      conn = put(conn, Routes.wallet_path(conn, :update, wallet), wallet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Wallet"
    end
  end

  describe "delete wallet" do
    setup [:create_wallet]

    test "deletes chosen wallet", %{conn: conn, wallet: wallet} do
      conn = delete(conn, Routes.wallet_path(conn, :delete, wallet))
      assert redirected_to(conn) == Routes.wallet_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.wallet_path(conn, :show, wallet))
      end
    end
  end

  defp create_wallet(_) do
    user = create_user()
    wallet = wallet_fixture(%{user_id: user.id})
    %{wallet: wallet}
  end

  defp create_user() do
    user_params = %{token: "FakeToken", email: "fakeemail@gmail.com", provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    {:ok, user} = CryptoDashboard.Repo.insert(changeset)
    user
  end
end
