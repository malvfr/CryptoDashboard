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

  describe "assets" do
    alias CryptoDashboard.Portfolio.Asset

    import CryptoDashboard.PortfolioFixtures

    @invalid_attrs %{asset_code: nil, quantity: nil, unit_price: nil}

    test "list_assets/0 returns all assets", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      asset = asset_fixture(%{wallet_id: wallet.id})
      assert Portfolio.list_assets(wallet.id) == [asset]
    end

    test "get_asset!/1 returns the asset with given id", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      asset = asset_fixture(%{wallet_id: wallet.id})
      assert Portfolio.get_asset!(asset.id) == asset
    end

    test "create_asset/1 with valid data creates a asset", state do
      wallet = wallet_fixture(%{user_id: state.user.id})

      valid_attrs = %{asset_code: 42, quantity: 120.5, unit_price: 120.5, wallet_id: wallet.id}

      assert {:ok, %Asset{} = asset} = Portfolio.create_asset(valid_attrs)
      assert asset.asset_code == 42
      assert asset.quantity == 120.5
      assert asset.unit_price == 120.5
      assert asset.wallet_id == wallet.id
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portfolio.create_asset(@invalid_attrs)
    end

    test "update_asset/2 with valid data updates the asset", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      asset = asset_fixture(%{wallet_id: wallet.id})
      update_attrs = %{asset_code: 43, quantity: 456.7, unit_price: 456.7}

      assert {:ok, %Asset{} = asset} = Portfolio.update_asset(asset, update_attrs)
      assert asset.asset_code == 43
      assert asset.quantity == 456.7
      assert asset.unit_price == 456.7
    end

    test "update_asset/2 with invalid data returns error changeset", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      asset = asset_fixture(%{wallet_id: wallet.id})
      assert {:error, %Ecto.Changeset{}} = Portfolio.update_asset(asset, @invalid_attrs)
      assert asset == Portfolio.get_asset!(asset.id)
    end

    test "delete_asset/1 deletes the asset", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      asset = asset_fixture(%{wallet_id: wallet.id})
      assert {:ok, %Asset{}} = Portfolio.delete_asset(asset)
      assert_raise Ecto.NoResultsError, fn -> Portfolio.get_asset!(asset.id) end
    end

    test "change_asset/1 returns a asset changeset", state do
      wallet = wallet_fixture(%{user_id: state.user.id})
      asset = asset_fixture(%{wallet_id: wallet.id})
      assert %Ecto.Changeset{} = Portfolio.change_asset(asset)
    end
  end
end
