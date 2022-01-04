defmodule CryptoDashboard.DynamicStreamerSupervisor do
  use DynamicSupervisor
  alias CryptoDashboard.Streamer.Binance
  require Logger

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_worker(symbol) do
    Logger.info("Starting streaming #{symbol} trade events")
    start_child(symbol)
  end

  defp start_child(args) do
    IO.inspect(args, label: "args", limit: :infinity)

    DynamicSupervisor.start_child(
      __MODULE__,
      {Binance, args}
    )
  end
end
