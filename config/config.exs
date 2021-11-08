# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :portal_cms,
  ecto_repos: [PortalCms.Repo]

# Configures the endpoint
config :portal_cms, PortalCmsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Xsj+PEe28U1NZ3M0mOw4FuqDMtQ4sktSKKdbgIRKFD5MDOmi1jU6gfg4L8+9Xx2x",
  render_errors: [view: PortalCmsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PortalCms.PubSub,
  live_view: [signing_salt: "vS3OsAEi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
