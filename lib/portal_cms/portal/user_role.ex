defmodule PortalCms.Portal.UserRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "userroles" do
    field :user_id, :id
    field :role_id, :id
    belongs_to :app, PortalCms.Portal.App

    timestamps()
  end

  @doc false
  def changeset(user_role, attrs) do
    user_role
    |> cast(attrs, [:user_id, :role_id, :app_id])
    |> validate_required([:user_id, :role_id,])
  end
end
