defmodule CryptoDashboardWeb.PageControllerTest do
  use CryptoDashboardWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Crypto Dashboard"
  end
end
