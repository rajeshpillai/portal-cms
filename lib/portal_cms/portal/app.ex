defmodule PortalCms.Portal.App do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name]}

  schema "apps" do
    field :name, :string
    has_many :navigations, PortalCms.Portal.Navigation
    has_many :content_page, PortalCms.Portal.ContentPage
    has_many :features, PortalCms.Portal.Feature
    has_many :roles, PortalCms.Portal.Role
    has_many :content_block, PortalCms.Portal.ContentBlock

    timestamps()
  end

  @doc false
  def changeset(app, attrs) do
    app
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
