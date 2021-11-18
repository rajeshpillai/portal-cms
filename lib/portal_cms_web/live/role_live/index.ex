defmodule PortalCmsWeb.RoleLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.Role

  @impl true
  def mount(%{"app_id" => app_id}, _session, socket) do

    {:ok, assign(socket, :roles, list_roles(app_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Role")
    |> assign(:role, Portal.get_role!(id))
  end

  defp apply_action(socket, :new, %{"app_id" => app_id}) do
    app = Portal.get_app!(app_id)

    changeset = Ecto.build_assoc(app, :roles, %Role{})


    socket
    |> assign(:page_title, "New Role")
    |> assign(:role, changeset)
    |> assign(:app, app)
  end

  defp apply_action(socket, :index, %{"app_id" => app_id}) do
    IO.puts("***APP_ID: #{app_id}")
    app = Portal.get_app!(app_id)
    IO.inspect app
    socket
    |> assign(:page_title, "Listing Roles")
    |> assign(:role, nil)
    |> assign(:app, app)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    role = Portal.get_role!(id)
    {:ok, _} = Portal.delete_role(role)

    {:noreply, assign(socket, :roles, list_roles(role.app_id))}
  end

  defp list_roles(app_id) do
    Portal.list_roles(app_id)
  end
end
