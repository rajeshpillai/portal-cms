defmodule PortalCmsWeb.NavigationLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.Navigation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :navigations, list_navigations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Navigation")
    |> assign(:navigation, Portal.get_navigation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Navigation")
    |> assign(:navigation, %Navigation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Navigations")
    |> assign(:navigation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    navigation = Portal.get_navigation!(id)
    {:ok, _} = Portal.delete_navigation(navigation)

    {:noreply, assign(socket, :navigations, list_navigations())}
  end

  defp list_navigations do
    Portal.list_navigations()
  end
end
