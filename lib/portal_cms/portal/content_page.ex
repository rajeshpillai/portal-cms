defmodule PortalCms.Portal.ContentPage do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :slug, :content, :is_published, :app_id]}

  schema "content_pages" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :slug, :string
    field :title, :string
    field :app_id, :id

    timestamps()
  end

  @doc false
  def changeset(content_page, attrs) do
    content_page
    |> cast(attrs, [:content, :slug, :title, :is_published])
    |> validate_required([:content, :slug, :title, :is_published])
  end
end
