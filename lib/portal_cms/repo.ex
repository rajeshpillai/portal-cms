defmodule PortalCms.Repo do
  use Ecto.Repo,
    otp_app: :portal_cms,
    adapter: Ecto.Adapters.Postgres
end
