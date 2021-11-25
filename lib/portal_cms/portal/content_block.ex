defmodule PortalCms.Portal.ContentBlock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "content_blocks" do
    field :content, :string
    field :is_published, :boolean, default: false
    field :type, :string
    # field :app_id, :id
    belongs_to  :app, PortalCms.Portal.App

    timestamps()
  end

  @doc false
  def changeset(content_block, attrs) do
    content_block
    |> cast(attrs, [:content, :is_published, :type])
    |> validate_required([:content, :is_published, :type])
  end
end
