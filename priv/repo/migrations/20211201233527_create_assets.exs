defmodule CryptoDashboard.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :asset_code, :integer
      add :quantity, :float
      add :unit_price, :float
      add :wallet_id, references(:wallets, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:assets, [:wallet_id])
  end
end
