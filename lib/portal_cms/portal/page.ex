defmodule PortalCms.Portal.Page do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :slug, :content, :is_published, :app_id]}

  schema "pages" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :slug, :string
    field :title, :string

    belongs_to  :app, PortalCms.Portal.App

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:title, :slug, :content, :is_published, :app_id])
    |> validate_required([:title, :slug, :content, :is_published])
  end
end
