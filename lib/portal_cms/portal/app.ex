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
    has_many :user_role, PortalCms.Portal.UserRole
    belongs_to :user, PortalCms.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  def create_changeset(app, attrs) do
    app
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end

  @doc false
  def changeset(app, attrs) do
    app
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
  end
end
