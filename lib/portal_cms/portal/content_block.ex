defmodule PortalCms.Portal.ContentBlock do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :content, :is_published, :app_id]}

  schema "content_blocks" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :type, :string
    field :slug, :string
    # field :app_id, :id
    belongs_to :app, PortalCms.Portal.App
    belongs_to :users, PortalCms.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  def create_changeset(content_block, attrs) do
    content_block
    |> cast(attrs, [:content, :is_published, :type, :slug, :app_id, :user_id])
    |> validate_required([:content, :is_published, :slug, :type, :user_id])
    |> unique_constraint(:slug)
  end

  @doc false
  def changeset(content_block, attrs) do
    content_block
    |> cast(attrs, [:content, :is_published, :type, :slug, :app_id, :user_id])
    |> validate_required([:content, :is_published, :slug, :type])
    |> unique_constraint(:slug)
  end
end
