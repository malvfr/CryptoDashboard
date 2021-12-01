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
end
