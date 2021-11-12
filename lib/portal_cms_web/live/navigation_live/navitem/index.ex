defmodule PortalCmsWeb.NavItemLive.Edit do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.NavItem

  @impl true
  def mount(_params, _session, socket) do
    IO.puts("NavItem mount..")
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <%= live_modal @socket, PortalCmsWeb.NavItemLive.FormComponent,
      id: @nav_item.id,
      title: @page_title,
      action: @live_action,
      nav_item: @nav_item,
      return_to: "/navigations/1"  %>

    """
  end

  def handle_event("update_nav_item", %{"nav_item" => nav_item_params}, socket) do
    save_nav_item(socket, :update_nav_item, nav_item_params)
  end

  defp save_nav_item(socket, :update_nav_item, nav_item_params) do
    IO.puts("**************************")
    IO.inspect nav_item_params
    nav_id = nav_item_params["navigation_id"]

    case Portal.update_nav_item(socket.assigns.nav_item, nav_item_params) do
      {:ok, _app} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nav item updated successfully")
         |> push_redirect(to: "/navigations/#{nav_id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp apply_action(socket, :edit_item, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Navigation")
    |> assign(:nav_item, Portal.get_nav_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Navigation")
    |> assign(:navigation, %NavItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Navigations")
    |> assign(:navigation, nil)
  end



  defp list_navitem do
    Portal.list_nav_items()
  end
end
