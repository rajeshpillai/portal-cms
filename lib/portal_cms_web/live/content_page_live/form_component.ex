defmodule PortalCmsWeb.ContentPageLive.FormComponent do
  use PortalCmsWeb, :live_component

  alias PortalCms.Portal

  @impl true
  def update(%{content_page: content_page} = assigns, socket) do
    changeset = Portal.change_content_page(content_page)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"content_page" => content_page_params}, socket) do
    changeset =
      socket.assigns.content_page
      |> Portal.change_content_page(content_page_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"content_page" => content_page_params}, socket) do
    save_content_page(socket, socket.assigns.action, content_page_params)
  end

  defp save_content_page(socket, :edit, content_page_params) do
    case Portal.update_content_page(socket.assigns.content_page, content_page_params) do
      {:ok, _content_page} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content page updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_content_page(socket, :new, content_page_params) do
    case Portal.create_content_page(content_page_params) do
      {:ok, _content_page} ->
        {:noreply,
         socket
         |> put_flash(:info, "Content page created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
