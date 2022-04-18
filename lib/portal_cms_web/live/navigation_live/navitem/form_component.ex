defmodule PortalCmsWeb.NavItemLive.FormComponent do
  use PortalCmsWeb, :live_component

  alias PortalCms.Portal

  @impl true
  def update(%{nav_item: nav_item} = assigns, socket) do
    changeset = Portal.change_nav_item(nav_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"nav_item" => nav_item_params}, socket) do
    changeset =
      socket.assigns.nav_item
      |> Portal.change_nav_item(nav_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("update_nav_item", %{"nav_item" => nav_item_params}, socket) do
    IO.puts("Update navitem: *****************")
    IO.inspect nav_item_params
    save_navigation(socket, socket.assigns.action, nav_item_params)
  end

  defp save_navigation(socket, :edit, nav_item_params) do
    case Portal.update_nav_item(socket.assigns.nav_item, nav_item_params) do
      {:ok, _navigation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Navigation updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_navigation(socket, :new, nav_item_params) do
    current_user = socket.assigns.current_user
    nav_item_params = Map.put(nav_item_params, "user_id", current_user.id)

    case Portal.create_nav_item(nav_item_params) do
      {:ok, _navigation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Nav item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
