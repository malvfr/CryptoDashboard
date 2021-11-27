defmodule CryptoDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CryptoDashboard.Repo,
      # Start the Telemetry supervisor
      CryptoDashboardWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CryptoDashboard.PubSub},
      # Start the Endpoint (http/https)
      CryptoDashboardWeb.Endpoint
      # Start a worker by calling: CryptoDashboard.Worker.start_link(arg)
      # {CryptoDashboard.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CryptoDashboard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CryptoDashboardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
