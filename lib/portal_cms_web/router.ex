defmodule PortalCmsWeb.Router do
  use PortalCmsWeb, :router

  import PortalCmsWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PortalCmsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
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

    live "/", PageLive, :index
    # live "/", AppLive.Index, :index

    # forward "/", Plugs.HomePageRedirector
  end

  scope "/api", PortalCmsWeb do
    pipe_through :json_api

    get "/navigations/:nav_id", PortalController, :get_navs
    get "/page/:id", PortalController, :get_content_page
    get "/content/:id", PortalController, :get_content_block
    get "/roles/:app_id", PortalController, :get_roles
    get "/features/:app_id", PortalController, :get_features

    get "/permissions/:app_id", PortalController, :get_permissions_by_app

    get "/apps", PortalController, :get_apps
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

  ## Authentication routes

  scope "/", PortalCmsWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", PortalCmsWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    # Access this pages after login only
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

    # live "/content_pages/:id", ContentPageLive.Show, :show
    # live "/content_pages/:id/show/edit", ContentPageLive.Show, :edit

    # Default genrated Features routes

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

    live "/app/:app_id/blocks/:app_id", ContentBlockLive.Index, :index
    live "/app/:app_id/blocks/new", ContentBlockLive.Index, :new
    live "/app/:app_id/blocks/:id/edit", ContentBlockLive.Index, :edit

    # live "/content_blocks/:id", ContentBlockLive.Show, :show
    # live "/content_blocks/:id/show/edit", ContentBlockLive.Show, :edit

    # permissions
    live "/permissions", PermissionLive.Index, :index
    live "/permissions/new", PermissionLive.Index, :new
    live "/permissions/:id/edit", PermissionLive.Index, :edit

    live "/permissions/:id", PermissionLive.Show, :show
    live "/permissions/:id/show/edit", PermissionLive.Show, :edit
  end

  scope "/", PortalCmsWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
