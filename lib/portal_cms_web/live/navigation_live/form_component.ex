defmodule PortalCmsWeb.NavigationLive.FormComponent do
  use PortalCmsWeb, :live_component

  alias PortalCms.Portal

  @impl true
  def update(%{navigation: navigation} = assigns, socket) do
    changeset = Portal.change_navigation(navigation)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"navigation" => navigation_params}, socket) do
    changeset =
      socket.assigns.navigation
      |> Portal.change_navigation(navigation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"navigation" => navigation_params}, socket) do
    save_navigation(socket, socket.assigns.action, navigation_params)
  end

  defp save_navigation(socket, :edit, navigation_params) do
    case Portal.update_navigation(socket.assigns.navigation, navigation_params) do
      {:ok, _navigation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Navigation updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_navigation(socket, :new, navigation_params) do
    case Portal.create_navigation(navigation_params) do
      {:ok, _navigation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Navigation created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
