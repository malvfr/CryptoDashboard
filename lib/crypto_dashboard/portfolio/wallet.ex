defmodule CryptoDashboard.Portfolio.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :bigint
  schema "wallets" do
    field :name, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
  end
end
