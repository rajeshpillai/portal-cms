defmodule PortalCmsWeb.PermissionLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.Permission

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :permissions, list_permissions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Permission")
    |> assign(:permission, Portal.get_permission!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Permission")
    |> assign(:permission, %Permission{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Permissions")
    |> assign(:permission, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    permission = Portal.get_permission!(id)
    {:ok, _} = Portal.delete_permission(permission)

    {:noreply, assign(socket, :permissions, list_permissions())}
  end

  defp list_permissions do
    Portal.list_permissions()
  end
end
