defmodule PortalCms.Portal.Navigation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "navigations" do
    field :name, :string
    # field :app_id, :id
    belongs_to  :app, PortalCms.Portal.App
    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(navigation, attrs) do
    navigation
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
