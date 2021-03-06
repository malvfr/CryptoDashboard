defmodule CryptoDashboardWeb.RealtimeDashboardLive.CurrencyBoxComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  @impl true
  def render(assigns) do
    ~H"""
    <div class="row">
      <div class="col s3 m3">
    <%=if @loading do %>
      <h1>Loading</h1>
    <%else %>
      <div class="card green darken-1">
        <div class="card-content white-text">
          <span class="card-title"><%=@event["s"]%></span>
          <p><%=@event["k"]["c"]%></p>
        </div>
      </div>
    <% end %>
      </div>
    </div>
    """
  end
end
