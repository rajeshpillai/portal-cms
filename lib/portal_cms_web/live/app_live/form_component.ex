defmodule PortalCmsWeb.AppLive.FormComponent do
  use PortalCmsWeb, :live_component

  alias PortalCms.Portal

  @impl true
  def update(%{app: app} = assigns, socket) do
    changeset = Portal.change_app(app)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"app" => app_params}, socket) do
    changeset =
      socket.assigns.app
      |> Portal.change_app(app_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"app" => app_params}, socket) do
    save_app(socket, socket.assigns.action, app_params)
  end

  defp save_app(socket, :edit, app_params) do
    case Portal.update_app(socket.assigns.app, app_params) do
      {:ok, _app} ->
        {:noreply,
         socket
         |> put_flash(:info, "App updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_app(socket, :new, app_params) do
    current_user = socket.assigns.current_user
    app_params = Map.put(app_params, "user_id", current_user.id)

    case Portal.create_app(app_params) do
      {:ok, _app} ->
        {:noreply,
         socket
         |> put_flash(:info, "App created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
