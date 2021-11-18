defmodule PortalCms.Portal.Feature do
  use Ecto.Schema
  import Ecto.Changeset

  schema "features" do
    field :name, :string
    # field :app_id, :id
    belongs_to  :app, PortalCms.Portal.App

    timestamps()
  end

  @doc false
  def changeset(feature, attrs) do
    feature
    |> cast(attrs, [:name, :app_id])
    |> validate_required([:name])
  end
end
