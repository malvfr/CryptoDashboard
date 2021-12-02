defmodule CryptoDashboardWeb.AssetControllerTest do
  use CryptoDashboardWeb.ConnCase

  import CryptoDashboard.PortfolioFixtures

  @create_attrs %{asset_code: 42, quantity: 120.5, unit_price: 120.5}
  @update_attrs %{asset_code: 43, quantity: 456.7, unit_price: 456.7}
  @invalid_attrs %{asset_code: nil, quantity: nil, unit_price: nil}

  describe "new asset" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.asset_path(conn, :new))
      assert html_response(conn, 200) =~ "New Asset"
    end
  end
end
