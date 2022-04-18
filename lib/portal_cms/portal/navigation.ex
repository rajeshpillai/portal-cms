defmodule PortalCms.Portal.Navigation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "navigations" do
    field :name, :string
    # field :app_id, :id
    belongs_to :app, PortalCms.Portal.App
    belongs_to :users, PortalCms.Accounts.User, foreign_key: :user_id
    timestamps()
  end

  def create_changeset(navigation, attrs) do
    navigation
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end

  @doc false
  def changeset(navigation, attrs) do
    navigation
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
  end
end
