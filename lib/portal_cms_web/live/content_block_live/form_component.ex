defmodule PortalCmsWeb.ContentBlockLive.FormComponent do
  use PortalCmsWeb, :live_component

  alias PortalCms.Portal

  @impl true
  def update(%{content_block: content_block} = assigns, socket) do
    changeset = Portal.change_content_block(content_block)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"content_block" => content_block_params}, socket) do
    changeset =
      socket.assigns.content_block
      |> Portal.change_content_block(content_block_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"content_block" => content_block_params}, socket) do
    save_content_block(socket, socket.assigns.action, content_block_params)
  end

  defp save_content_block(socket, :edit, content_block_params) do
    case Portal.update_content_block(socket.assigns.content_block, content_block_params) do
      {:ok, _content_block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content block updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_content_block(socket, :new, content_block_params) do
    case Portal.create_content_block(content_block_params) do
      {:ok, _content_block} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content block created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
