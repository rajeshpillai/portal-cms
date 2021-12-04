defmodule PortalCms.Portal.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :feature_id]}

  schema "permissions" do
    field :name, :string
    #  field :feature_id, :id
    belongs_to :feature, PortalCms.Portal.Feature

    timestamps()
  end

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, [:name,:feature_id])
    |> validate_required([:name])
  end
end
