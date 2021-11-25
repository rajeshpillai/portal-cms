defmodule PortalCms.Portal.ContentBlock do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id,  :content, :is_published, :app_id]}

  schema "content_blocks" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :type, :string
    field :slug, :string
    # field :app_id, :id
    belongs_to  :app, PortalCms.Portal.App

    timestamps()
  end

  @doc false
  def changeset(content_block, attrs) do
    content_block
    |> cast(attrs, [:content, :is_published, :type, :slug, :app_id])
    |> validate_required([:content, :is_published, :slug, :type])
  end
end
