defmodule PortalCmsWeb.ContentPageLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.ContentPage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :content_pages, list_content_pages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Content page")
    |> assign(:content_page, Portal.get_content_page!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Content page")
    |> assign(:content_page, %ContentPage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Content pages")
    |> assign(:content_page, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_page = Portal.get_content_page!(id)
    {:ok, _} = Portal.delete_content_page(content_page)

    {:noreply, assign(socket, :content_pages, list_content_pages())}
  end

  defp list_content_pages do
    Portal.list_content_pages()
  end
end
