defmodule PortalCmsWeb.NavigationLive.Show do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.NavItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [nav_items: []]}
  end

  @impl true
  @spec handle_params(map, any, Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_params(%{"id" => id}, _, socket) do
    nav_items = Portal.list_nav_items(id)
    changeset = Portal.change_nav_item(%NavItem{}, %{navigation_id: id})

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:navigation, Portal.get_navigation_with_app!(id))
     |> assign(:nav_items, nav_items)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    IO.puts("DELETE***************** #{id}")
    navigation = Portal.get_nav_item!(id)
    {:ok, _} = Portal.delete_nav_item(navigation)

    {:noreply, assign(socket, :nav_items, list_navitem())}
  end

  @impl true
  def handle_event("add_nav_item", %{"nav_item" => params}, socket) do
    IO.puts("ADD_NAV_ITEM *****************")
    IO.inspect params

    case Portal.create_nav_item(params) do
      {:ok, nav_item} ->
        socket =
          update(
            socket,
            :nav_items,
            fn nav_items -> [nav_item | nav_items] end
          )

        changeset = Portal.change_nav_item(%NavItem{}, %{navigation_id: nav_item.navigation_id})
        nav_items = Portal.list_nav_items(nav_item.navigation_id)

        socket = socket |>
            assign(changeset: changeset) |>
            assign(nav_items: nav_items)

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        # changeset = changeset |>
        #   Map.put(:action, :insert)

        IO.inspect( changeset)
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  defp page_title(:show), do: "Show Navigation"
  defp page_title(:edit), do: "Edit Navigation"


  defp list_navitem do
    Portal.list_nav_items()
  end
end
