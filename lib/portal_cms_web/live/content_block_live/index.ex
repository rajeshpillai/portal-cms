defmodule PortalCmsWeb.ContentBlockLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.ContentBlock

  @impl true
  def mount(%{"app_id" => app_id} = params, session, socket) do
    socket = assign_defaults(session, socket)
    app = Portal.get_app!(app_id)
    socket = socket
        |> assign(:content_blocks, list_content_blocks(app.id))
        |> assign(:app, app)

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
    |> assign(:page_title, "Edit Content block")
    |> assign(:content_block, Portal.get_content_block!(id))
    |> assign(:app, app)
  end

  defp apply_action(socket, :new, %{"app_id" => app_id}) do
    app = Portal.get_app!(app_id)

    content_block = Ecto.build_assoc(app, :content_block, %ContentBlock{})
    IO.inspect content_block


    socket
    |> assign(:page_title, "New Content block")
    |> assign(:content_block, content_block)
    |> assign(:app, app)
  end

  defp apply_action(socket, :index,  %{"app_id" => id}) do
    app = Portal.get_app!(id)
    IO.inspect app

    socket
    |> assign(:page_title, "Listing Content blocks")
    |> assign(:content_block, nil)
    |> assign(:app, app)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    content_block = Portal.get_content_block!(id)
    {:ok, _} = Portal.delete_content_block(content_block)
    {:noreply, assign(socket, :content_blocks, list_content_blocks(content_block.app_id))}
  end

  defp list_content_blocks(app_id) do
    Portal.list_content_blocks(app_id)
  end
end
