defmodule PortalCmsWeb.ContentPageLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.ContentPage

  @impl true
  def mount(%{"app_id" => id} = params, _session, socket) do
    app = Portal.get_app!(id)
    socket = socket
        |> assign(:content_pages, list_content_pages())
        |> assign(:app, app)

    # {:ok, assign(socket, :content_pages, list_content_pages())}
    {:ok, socket}

  end

  @impl true
  def handle_params(%{"app_id" => app_id} = params, _url, socket) do
    IO.puts("Content Pages: #{app_id} ==> ")
    IO.inspect params
    app = Portal.get_app!(app_id)
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id, "app_id" => app_id} ) do
    app = Portal.get_app!(app_id)

    socket
    |> assign(:page_title, "Edit Content page")
    |> assign(:content_page, Portal.get_content_page!(id))
    |> assign(:app, app)
  end

  defp apply_action(socket, :new, %{"app_id" => app_id}) do
    app = Portal.get_app!(app_id)

    socket
    |> assign(:page_title, "New Content page")
    |> assign(:content_page, %ContentPage{})
    |> assign(:app, app)
  end

  defp apply_action(socket, :index,  %{"app_id" => id}) do
    app = Portal.get_app!(id)
    IO.inspect app

    socket
    |> assign(:page_title, "Listing Content pages")
    |> assign(:content_page, nil)
    |> assign(:app, app)
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
