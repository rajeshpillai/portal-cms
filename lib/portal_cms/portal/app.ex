defmodule PortalCms.Portal.App do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apps" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(app, attrs) do
    app
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end