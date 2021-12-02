defmodule CryptoDashboard.PortfolioFixtures do

  @moduledoc """
  This module defines test helpers for creating
  entities via the `CryptoDashboard.Portfolio` context.
  """

  @doc """
  Generate a wallet.
  """
  def wallet_fixture(attrs \\ %{}) do
    {:ok, wallet} =
      attrs
      |> Enum.into(%{
        name: "some name",
        user_id: attrs.user_id
      })
      |> CryptoDashboard.Portfolio.create_wallet()

    wallet
  end

  @doc """
  Generate a asset.
  """
  def asset_fixture(attrs \\ %{}) do
    {:ok, asset} =
      attrs
      |> Enum.into(%{
        asset_code: 42,
        quantity: 120.5,
        unit_price: 120.5,
        wallet_id: attrs.wallet_id
      })
      |> CryptoDashboard.Portfolio.create_asset()

    asset
  end
end
