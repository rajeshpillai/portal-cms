defmodule PortalCms.Portal.Feature do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :app_id]}

  schema "features" do
    field :name, :string
    # field :app_id, :id
    belongs_to :app, PortalCms.Portal.App
    has_many :permissions, PortalCms.Portal.Permission
    belongs_to :users, PortalCms.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  def create_changeset(feature, attrs) do
    feature
    |> cast(attrs, [:name, :app_id, :user_id])
    |> validate_required([:name, :user_id])
  end

  @doc false
  def changeset(feature, attrs) do
    feature
    |> cast(attrs, [:name, :app_id, :user_id])
    |> validate_required([:name])
  end
end
