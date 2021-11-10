defmodule PortalCms.Portal.NavItem do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :url, :seq_no, :parent_id]}

  schema "nav_items" do
    field :title, :string
    field :url, :string
    field :seq_no, :integer
    # field :navigation_id, :id
    # field :parent_id, :id

    belongs_to  :navigation, PortalCms.Portal.Navigation
    belongs_to  :nav_items, PortalCms.Portal.NavItem, foreign_key: :parent_id

    timestamps()
  end

  @doc false
  def changeset(nav_item, attrs) do
    nav_item
    |> cast(attrs, [:title, :url, :navigation_id, :seq_no, :parent_id])
    |> validate_required([:title, :url])
  end
end
