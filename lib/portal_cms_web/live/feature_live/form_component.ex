defmodule PortalCmsWeb.FeatureLive.FormComponent do
  use PortalCmsWeb, :live_component

  alias PortalCms.Portal

  @impl true
  def update(%{feature: feature} = assigns, socket) do
    changeset = Portal.change_feature(feature)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"feature" => feature_params}, socket) do
    changeset =
      socket.assigns.feature
      |> Portal.change_feature(feature_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"feature" => feature_params}, socket) do
    save_feature(socket, socket.assigns.action, feature_params)
  end

  defp save_feature(socket, :edit, feature_params) do
    case Portal.update_feature(socket.assigns.feature, feature_params) do
      {:ok, _feature} ->
        {:noreply,
         socket
         |> put_flash(:info, "Feature updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_feature(socket, :new, feature_params) do
    case Portal.create_feature(feature_params) do
      {:ok, _feature} ->
        {:noreply,
         socket
         |> put_flash(:info, "Feature created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
