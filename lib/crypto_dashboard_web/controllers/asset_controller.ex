defmodule CryptoDashboardWeb.AssetController do
  use CryptoDashboardWeb, :controller

  alias CryptoDashboard.Portfolio
  alias CryptoDashboard.Portfolio.Asset

  def index(conn, params) do
    wallet_id =
      cond do
        params["wallet_id"] -> params["wallet_id"]
        conn.assigns[:wallet].id -> conn.assigns[:wallet].id
      end

    conn =
      conn
      |> put_session(:wallet_id, wallet_id)

    conn =
      cond do
        wallet = wallet_id && Portfolio.get_wallet!(wallet_id) ->
          assign(conn, :wallet, wallet)

        true ->
          assign(conn, :wallet, nil)
      end

    assets = Portfolio.list_assets(wallet_id)
    render(conn, "index.html", assets: assets)
  end

  def new(conn, _params) do
    changeset = Portfolio.change_asset(%Asset{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"asset" => asset_params}) do
    asset_params = Map.put(asset_params, "wallet_id", conn.assigns[:wallet].id)

    case Portfolio.create_asset(asset_params) do
      {:ok, asset} ->
        conn
        |> put_flash(:info, "Asset created successfully.")
        |> redirect(to: Routes.asset_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, params) do
    assets = Portfolio.list_asset(params["id"])
    render(conn, "show.html", assets: assets)
  end

  def edit(conn, %{"id" => id}) do
    asset = Portfolio.get_asset!(id)
    changeset = Portfolio.change_asset(asset)
    render(conn, "edit.html", asset: asset, changeset: changeset)
  end

  def update(conn, %{"id" => id, "asset" => asset_params}) do
    asset = Portfolio.get_asset!(id)

    case Portfolio.update_asset(asset, asset_params) do
      {:ok, asset} ->
        conn
        |> put_flash(:info, "Asset updated successfully.")
        |> redirect(to: Routes.asset_path(conn, :show, asset.asset_code))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", asset: asset, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    asset = Portfolio.get_asset!(id)
    {:ok, _asset} = Portfolio.delete_asset(asset)

    conn
    |> put_flash(:info, "Asset deleted successfully.")
    |> redirect(to: Routes.asset_path(conn, :index))
  end
end
