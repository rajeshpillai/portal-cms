defmodule PortalCms.Repo.Migrations.CreateContentBlocks do
  use Ecto.Migration

  def change do
    create table(:content_blocks) do
      add :content, :text
      add :is_published, :boolean, default: false, null: false
      add :type, :string
      add :slug, :string
      add :app_id, references(:apps, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:content_blocks, [:app_id])
    create unique_index(:content_blocks, [:slug])
    create index(:content_blocks, [:user_id])
  end
end
