defmodule CryptoDashboard.PortfolioTest do
  use CryptoDashboard.DataCase

  alias CryptoDashboard.Portfolio
  alias CryptoDashboard.Models.User

  setup_all do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, :auto)

    user_params = %{token: "FakeToken", email: "fakeemail@gmail.com", provider: "github"}
    changeset = User.changeset(%User{}, user_params)
    {:ok, user} = CryptoDashboard.Repo.insert(changeset)

    {:ok, user: user}
  end



  describe "wallets" do
    alias CryptoDashboard.Portfolio.Wallet

    import CryptoDashboard.PortfolioFixtures

    @invalid_attrs %{name: nil}

    test "list_wallets/0 returns all wallets", state do

      wallet = wallet_fixture(%{user_id: state.user.id})
      assert Portfolio.list_wallets(state.user.id) == [wallet]
    end

    test "get_wallet!/1 returns the wallet with given id", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      assert Portfolio.get_wallet!(wallet.id) == wallet
    end

    test "create_wallet/1 with valid data creates a wallet" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Wallet{} = wallet} = Portfolio.create_wallet(valid_attrs)
      assert wallet.name == "some name"
    end

    test "create_wallet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolio.create_wallet(@invalid_attrs)
    end

    test "update_wallet/2 with valid data updates the wallet", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Wallet{} = wallet} = Portfolio.update_wallet(wallet, update_attrs)
      assert wallet.name == "some updated name"
    end

    test "update_wallet/2 with invalid data returns error changeset", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      assert {:error, %Ecto.Changeset{}} = Portfolio.update_wallet(wallet, @invalid_attrs)
      assert wallet == Portfolio.get_wallet!(wallet.id)
    end

    test "delete_wallet/1 deletes the wallet", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      assert {:ok, %Wallet{}} = Portfolio.delete_wallet(wallet)
      assert_raise Ecto.NoResultsError, fn -> Portfolio.get_wallet!(wallet.id) end
    end

    test "change_wallet/1 returns a wallet changeset", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      assert %Ecto.Changeset{} = Portfolio.change_wallet(wallet)
    end
  end
end
