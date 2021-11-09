defmodule PortalCmsWeb.AppLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.App

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :apps, list_apps())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit App")
    |> assign(:app, Portal.get_app!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New App")
    |> assign(:app, %App{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Apps")
    |> assign(:app, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    app = Portal.get_app!(id)
    {:ok, _} = Portal.delete_app(app)

    {:noreply, assign(socket, :apps, list_apps())}
  end

  defp list_apps do
    Portal.list_apps()
  end
end
