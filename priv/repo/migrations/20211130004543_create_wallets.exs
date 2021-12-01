defmodule CryptoDashboard.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing, type: :bigint)

      timestamps()
    end

    create index(:wallets, [:user_id])
  end
end
