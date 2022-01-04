defmodule CryptoDashboardWeb.RealtimeDashboardLive do
  alias CryptoDashboardWeb.RealtimeDashboardLive.CurrencyBoxComponent
  use CryptoDashboardWeb, :live_view
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    assets = ["btcusdt", "ethusdt", "xrpusdt"]
    CryptoDashboard.subscribe(assets)

    socket = assign(socket, card_ids: assets, event: %{"s" => ""}, loading: true)
    {:ok, socket}
  end

  def handle_info(msg, socket) do
    Logger.debug("HANDLE_INFO message: #{inspect(msg)}")
    Logger.debug("HANDLE_INFO socket: #{inspect(socket.assigns)}")

    send_update(CurrencyBoxComponent,
      id: msg["s"] |> String.downcase(),
      event: msg,
      loading: false
    )

    {:noreply, socket}
  end
end
