defmodule PortalCmsWeb.Plugs.HomePageRedirector do
  alias PortalCmsWeb.Router.Helpers, as: Routes

  def init(default), do: default

  def call(conn, _opts) do
    welcome_path = Routes.app_index_path(conn, :index)
    IO.puts("***************** #{welcome_path}")

    conn
    |> Phoenix.Controller.redirect(to: welcome_path)
    |> Plug.Conn.halt()
  end
end
