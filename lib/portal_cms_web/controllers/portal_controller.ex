defmodule PortalCmsWeb.PortalController do
  use PortalCmsWeb, :controller

  alias PortalCms.Portal
  # alias PortalCms.Portal.NavItem

  # def index(conn, _params) do
  def index(conn, %{"nav_id" => id}) do
    nav_items = Portal.list_nav_items(id)

    json(conn, %{data: nav_items})
  end
end
