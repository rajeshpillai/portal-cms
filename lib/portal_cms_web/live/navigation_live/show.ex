defmodule PortalCmsWeb.NavigationLive.Show do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.NavItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  @spec handle_params(map, any, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_params(%{"id" => id}, _, socket) do
    nav_items = Portal.list_nav_items(id)
    changeset = Portal.change_nav_item(%NavItem{})

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:navigation, Portal.get_navigation_with_app!(id))
     |> assign(:nav_items, nav_items)
     |> assign(:changeset, changeset)}
  end

  defp page_title(:show), do: "Show Navigation"
  defp page_title(:edit), do: "Edit Navigation"
end
