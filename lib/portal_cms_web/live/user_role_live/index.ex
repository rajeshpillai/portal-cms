defmodule PortalCmsWeb.UserRoleLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.UserRole
  alias PortalCms.Repo

  import Ecto.Query, only: [from: 2]

  @impl true
  def mount(%{"app_id" => app_id}, _session, socket) do
    {:ok, assign(socket, :userroles, list_userroles(app_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id, "app_id" => app_id}) do
    app = Portal.get_app!(app_id)
    appRole = Portal.get_app!(app_id) |> Repo.preload([:roles])

    usersList = Repo.all(PortalCms.Accounts.User)
    users = Enum.map(usersList, &{"#{&1.email}", &1.id})

    userRole = Portal.get_user_role!(id)

    query =
      from u in PortalCms.Portal.UserRole,
        where:
          u.user_id == type(^userRole.user_id, :integer) and u.app_id == type(^app_id, :integer),
        select: u.role_id

    existRoles = Repo.all(query)

    socket
    |> assign(:page_title, "Edit User role")
    |> assign(:user_role, userRole)
    |> assign(:existRoles, existRoles)
    |> assign(:app, app)
    |> assign(:appRoles, appRole.roles)
    |> assign(:users, users)
    |> assign(:actions, "edit")
  end

  defp apply_action(socket, :new, %{"app_id" => app_id}) do
    app = Portal.get_app!(app_id)
    appRole = Portal.get_app!(app_id) |> Repo.preload([:roles])

    usersList = Repo.all(PortalCms.Accounts.User)
    users = Enum.map(usersList, &{"#{&1.email}", &1.id})

    user_role = Ecto.build_assoc(app, :user_role, %UserRole{})

    query =
      from u in PortalCms.Portal.UserRole,
        where: u.user_id == type(^"1", :integer) and u.app_id == type(^app_id, :integer),
        select: u.role_id

    existRoles = Repo.all(query)

    socket
    |> assign(:page_title, "New User role")
    |> assign(:user_role, user_role)
    |> assign(:app, app)
    |> assign(:appRoles, appRole.roles)
    |> assign(:users, users)
    |> assign(:existRoles, existRoles)
    |> assign(:actions, "new")
  end

  defp apply_action(socket, :index, %{"app_id" => app_id}) do
    app = Portal.get_app!(app_id)

    socket
    |> assign(:page_title, "Listing Userroles")
    |> assign(:user_role, nil)
    |> assign(:app, app)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_role = Portal.get_user_role!(id)
    {:ok, _} = Portal.delete_user_role(user_role)

    {:noreply, assign(socket, :userroles, list_userroles(user_role.app_id))}
  end

  defp list_userroles(app_id) do
    Portal.list_userroles(app_id)
  end

  defp findUsernameByUserId(user_id) do
    user = Repo.get!(PortalCms.Accounts.User, user_id)
    user.email
  end

  defp findRolenameByRoleId(role_id) do
    role = Repo.get!(PortalCms.Portal.Role, role_id)
    role.name
  end
end
