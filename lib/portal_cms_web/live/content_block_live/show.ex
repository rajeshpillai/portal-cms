defmodule PortalCmsWeb.ContentBlockLive.Show do
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
     |> assign(:content_block, Portal.get_content_block!(id))}
  end

  defp page_title(:show), do: "Show Content block"
  defp page_title(:edit), do: "Edit Content block"
end
