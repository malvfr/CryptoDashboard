defmodule CryptoDashboard.Enums.CurrencyEnum do
  @list [
    {"BTC", 0},
    {"ETH", 1},
    {"BNB", 2},
    {"USDT", 3},
    {"SOL", 4},
    {"ADA", 5},
    {"XRP", 6},
    {"USDC", 7},
    {"DOT", 8},
    {"DOGE", 9}
  ]

  def all do
    @list
  end

  def toString(number) do
    Map.new(@list, fn {key, val} -> {val, key} end)
    |> Map.get(number, number)
  end
end
