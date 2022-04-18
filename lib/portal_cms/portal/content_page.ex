defmodule PortalCms.Portal.ContentPage do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :slug, :content, :is_published, :app_id]}

  schema "content_pages" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :slug, :string
    field :title, :string
    # field :app_id, :id

    belongs_to :app, PortalCms.Portal.App
    belongs_to :users, PortalCms.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  def create_changeset(content_page, attrs) do
    content_page
    |> cast(attrs, [:id, :content, :slug, :title, :is_published, :app_id, :user_id])
    |> validate_required([:content, :slug, :title, :is_published, :user_id])
    |> unique_constraint(:slug)
  end

  @doc false
  def changeset(content_page, attrs) do
    content_page
    |> cast(attrs, [:id, :content, :slug, :title, :is_published, :app_id, :user_id])
    |> validate_required([:content, :slug, :title, :is_published])
    |> unique_constraint(:slug)
  end
end
