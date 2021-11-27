defmodule CryptoDashboard.Repo do
  use Ecto.Repo,
    otp_app: :crypto_dashboard,
    adapter: Ecto.Adapters.Postgres
end
