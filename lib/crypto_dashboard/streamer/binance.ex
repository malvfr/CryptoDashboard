defmodule CryptoDashboard.Streamer.Binance do
  use WebSockex
  require Logger

  @stream_endpoint "wss://stream.binance.com:9443/ws/"

  def start_link(symbol, state \\ []) do
    WebSockex.start_link(
      "#{@stream_endpoint}#{symbol}@kline_1m",
      __MODULE__,
      state
    )
  end

  def handle_frame({type, msg}, state) do
    # IO.puts("Received Message - Type: #{inspect(type)} -- Message: #{inspect(msg)}")

    case Jason.decode(msg) do
      {:ok, %{"s" => symbol} = message} ->
        Phoenix.PubSub.broadcast(
          CryptoDashboard.PubSub,
          "currency-#{String.downcase(symbol)}",
          message
        )

      {:error, error} ->
        Logger.error(error)
    end

    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    Logger.info("Sending #{type} frame with payload: #{msg}")
    {:reply, frame, state}
  end
end
