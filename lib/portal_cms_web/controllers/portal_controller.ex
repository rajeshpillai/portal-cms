defmodule PortalCmsWeb.PortalController do
  use PortalCmsWeb, :controller

  alias PortalCms.Portal
  # alias PortalCms.Portal.NavItem

  # def index(conn, _params) do
  def get_navs(conn, %{"nav_id" => id}) do
    nav_items = Portal.list_nav_items(id)

    json(conn, %{data: nav_items})
  end


  def get_content_page(conn, %{"id" => id}) do
    pages = Portal.get_content_page!(id)

    json(conn, %{data: pages})
  end

  def get_content_block(conn, %{"id" => id}) do
    content = Portal.get_content_block!(id)

    json(conn, %{data: content})
  end

  def get_roles(conn, %{"app_id" => app_id})  do
      roles = Portal.list_roles(app_id)
      json(conn, %{data: roles})
  end

  def get_features(conn, %{"app_id" => app_id})  do
      features = Portal.list_features(app_id)
      json(conn, %{data: features})
  end

  def get_permissions_by_app(conn, %{"app_id" => app_id})  do
    permissions = Portal.list_permissions(app_id)
    json(conn, %{data: permissions})
  end

  def get_apps(conn,_) do
      apps = Portal.list_apps
      json(conn, %{data: apps})
  end
end
