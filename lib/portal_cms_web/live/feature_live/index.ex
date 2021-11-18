defmodule PortalCmsWeb.FeatureLive.Index do
  use PortalCmsWeb, :live_view

  alias PortalCms.Portal
  alias PortalCms.Portal.Feature

  @impl true
  def mount(%{"app_id" => app_id}, _session, socket) do

    {:ok, assign(socket, :features, list_features(app_id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Feature")
    |> assign(:feature, Portal.get_feature!(id))
  end

  defp apply_action(socket, :new, %{"app_id" => app_id}) do
    app = Portal.get_app!(app_id)

    changeset = Ecto.build_assoc(app, :features, %Feature{})


    socket
    |> assign(:page_title, "New Feature")
    |> assign(:feature, changeset)
    |> assign(:app, app)
  end

  defp apply_action(socket, :index, %{"app_id" => app_id}) do
    IO.puts("***APP_ID: #{app_id}")
    app = Portal.get_app!(app_id)
    IO.inspect app
    socket
    |> assign(:page_title, "Listing Features")
    |> assign(:feature, nil)
    |> assign(:app, app)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    feature = Portal.get_feature!(id)
    {:ok, _} = Portal.delete_feature(feature)

    {:noreply, assign(socket, :features, list_features(feature.app_id))}
  end

  defp list_features(app_id) do
    Portal.list_features(app_id)
  end
end
