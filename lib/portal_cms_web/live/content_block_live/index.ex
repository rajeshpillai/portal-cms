defmodule PortalCmsWeb.ContentBlockLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.ContentBlock

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :content_blocks, list_content_blocks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Content block")
    |> assign(:content_block, Portal.get_content_block!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Content block")
    |> assign(:content_block, %ContentBlock{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Content blocks")
    |> assign(:content_block, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_block = Portal.get_content_block!(id)
    {:ok, _} = Portal.delete_content_block(content_block)

    {:noreply, assign(socket, :content_blocks, list_content_blocks())}
  end

  defp list_content_blocks do
    Portal.list_content_blocks()
  end
end
