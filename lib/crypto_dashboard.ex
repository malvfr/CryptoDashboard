defmodule CryptoDashboard do
  @moduledoc """
  CryptoDashboard keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def subscribe(symbol) do
    Enum.each(symbol, fn s ->
      Phoenix.PubSub.subscribe(CryptoDashboard.PubSub, "currency-#{s}")
    end)
  end
end
