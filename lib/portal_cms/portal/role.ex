defmodule PortalCms.Portal.Role do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :app_id]}

  schema "roles" do
    field :name, :string
    belongs_to :app, PortalCms.Portal.App
    belongs_to :users, PortalCms.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  def create_changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :app_id, :user_id])
    |> validate_required([:name, :user_id])
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :app_id, :user_id])
    |> validate_required([:name])
  end
end
