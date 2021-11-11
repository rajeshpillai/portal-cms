defmodule PortalCmsWeb.PageLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.Page

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [nav_items: []]}
  end

  @impl true
  @spec handle_params(map, any, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}

  def handle_params(%{"app_id" => id}, _, socket) do
    IO.puts("Pages Index: #{id}")
    pages = Portal.list_pages(id)
    changeset = Portal.change_page(%Page{}, %{app_id: id})

    {:noreply,
     socket
     |> assign(:app_id, id)
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pages, pages)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("add_page", %{"page" => params}, socket) do
    case Portal.create_page(params) do
      {:ok, page} ->
        socket =
          update(
            socket,
            :page,
            fn pages -> [page | pages] end
          )

        changeset = Portal.change_page(%Page{}, %{app_id: page.app_id})
        pages = Portal.list_pages(page.app_id)

        socket = socket |>
            assign(changeset: changeset) |>
            assign(nav_items: pages)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        # changeset = changeset |>
        #   Map.put(:action, :insert)

        IO.inspect( changeset)
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  defp page_title(:index), do: "All App Pages"
  defp page_title(:show), do: "Show Navigation"
  defp page_title(:edit), do: "Edit Navigation"

end
