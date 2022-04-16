defmodule PortalCmsWeb.UserRoleLive.FormComponent do
  use PortalCmsWeb, :live_component

  alias PortalCms.Portal

  @impl true
  def update(%{user_role: user_role} = assigns, socket) do
    changeset = Portal.change_user_role(user_role)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_role" => user_role_params}, socket) do
    changeset =
      socket.assigns.user_role
      |> Portal.change_user_role(user_role_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user_role" => user_role_params}, socket) do
    IO.inspect(user_role_params, label: "user_role_params")
    save_user_role(socket, socket.assigns.action, user_role_params)
  end

  defp save_user_role(socket, :edit, user_role_params) do
    case Portal.update_user_role(socket.assigns.user_role, user_role_params) do
      {:ok, _user_role} ->
        {:noreply,
         socket
         |> put_flash(:info, "User role updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user_role(socket, :new, user_role_params) do
    case Portal.create_user_role(user_role_params) do
      {:ok, _user_role} ->
        {:noreply,
         socket
         |> put_flash(:info, "User role created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
