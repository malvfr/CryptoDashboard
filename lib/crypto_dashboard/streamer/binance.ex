defmodule CryptoDashboard.Streamer.Binance do
  use WebSockex

  @stream_endpoint "wss://stream.binance.com:9443/ws/"

  def start_link(symbol, state) do
    IO.inspect(symbol, label: "symbol", limit: :infinity)

    WebSockex.start_link(
      "#{@stream_endpoint}#{symbol}@kline_1m",
      __MODULE__,
      state
    )
  end

  def handle_frame({type, msg}, state) do
    IO.puts("Received Message - Type: #{inspect(type)} -- Message: #{inspect(msg)}")

    case Jason.decode(msg) do
      {:ok, message} -> IO.inspect(message)
      {:error, error} -> IO.inspect(error)
    end

    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts("Sending #{type} frame with payload: #{msg}")
    {:reply, frame, state}
  end
end
