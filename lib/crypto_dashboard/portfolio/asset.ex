defmodule CryptoDashboard.Portfolio.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "assets" do
    field :asset_code, :integer
    field :quantity, :float
    field :unit_price, :float
    field :wallet_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:asset_code, :quantity, :unit_price, :wallet_id])
    |> validate_required([:asset_code, :quantity, :unit_price, :wallet_id])
  end
end
