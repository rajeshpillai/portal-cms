defmodule PortalCmsWeb.NavigationLive.Show do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:navigation, Portal.get_navigation!(id))}
  end

  defp page_title(:show), do: "Show Navigation"
  defp page_title(:edit), do: "Edit Navigation"
end
