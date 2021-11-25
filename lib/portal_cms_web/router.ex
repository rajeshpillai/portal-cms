defmodule PortalCmsWeb.Router do
  use PortalCmsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PortalCmsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # todo: RP
  pipeline :json_api do
    plug :accepts, ["json-api"]
  end

  scope "/", PortalCmsWeb do
    pipe_through [:browser]

    # live "/", PageLive, :index
    live "/", AppLive.Index, :index

    # forward "/", Plugs.HomePageRedirector

    live "/apps", AppLive.Index, :index
    live "/apps/new", AppLive.Index, :new
    live "/apps/:id/edit", AppLive.Index, :edit

    live "/apps/:id", AppLive.Show, :show
    live "/apps/:id/show/edit", AppLive.Show, :edit

    # Navigation
    live "/navigations", NavigationLive.Index, :index
    live "/navigations/new", NavigationLive.Index, :new
    live "/navigations/:id/edit", NavigationLive.Index, :edit

    live "/navigations/:id", NavigationLive.Show, :show
    live "/navigations/:id/show/edit", NavigationLive.Show, :edit


    live "/navitem/:id/edit", NavItemLive.Edit, :edit_item

    live "/app/:app_id/pages", ContentPageLive.Index, :index
    live "/app/:app_id/pages/new", ContentPageLive.Index, :new
    live "/app/:app_id/pages/:id/edit", ContentPageLive.Index, :edit

    live "/content_pages/:id", ContentPageLive.Show, :show
    live "/content_pages/:id/show/edit", ContentPageLive.Show, :edit


    #Default genrated Features routes

    # live "/features", FeatureLive.Index, :index
    # live "/features/new", FeatureLive.Index, :new
    # live "/features/:id/edit", FeatureLive.Index, :edit

    # live "/features/:id", FeatureLive.Show, :show
    # live "/features/:id/show/edit", FeatureLive.Show, :edit

    # New routes
    live "/features/:app_id", FeatureLive.Index, :index
    live "/features/:app_id/new", FeatureLive.Index, :new
    live "/features/:id/edit", FeatureLive.Index, :edit

    # live "/roles", RoleLive.Index, :index
    # live "/roles/new", RoleLive.Index, :new
    # live "/roles/:id/edit", RoleLive.Index, :edit

    # live "/roles/:id", RoleLive.Show, :show
    # live "/roles/:id/show/edit", RoleLive.Show, :edit

    live "/roles/:app_id", RoleLive.Index, :index
    live "/roles/:app_id/new", RoleLive.Index, :new
    live "/roles/:id/edit", RoleLive.Index, :edit


    # Content block
    live "/content_blocks", ContentBlockLive.Index, :index
    live "/content_blocks/new", ContentBlockLive.Index, :new
    live "/content_blocks/:id/edit", ContentBlockLive.Index, :edit

    live "/content_blocks/:id", ContentBlockLive.Show, :show
    live "/content_blocks/:id/show/edit", ContentBlockLive.Show, :edit
  end

  scope "/api", PortalCmsWeb do
    pipe_through :json_api

    get "/navigations/:nav_id", PortalController, :get_navs
    get "/page/:id", PortalController, :get_content_page
  end

  # Other scopes may use custom stacks.
  # scope "/api", PortalCmsWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PortalCmsWeb.Telemetry
    end
  end
end
