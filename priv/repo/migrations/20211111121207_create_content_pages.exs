defmodule PortalCms.Repo.Migrations.CreateContentPages do
  use Ecto.Migration

  def change do
    create table(:content_pages) do
      add :content, :text
      add :slug, :string
      add :title, :string
      add :is_published, :boolean, default: false, null: false
      add :app_id, references(:apps, on_delete: :nothing)

      timestamps()
    end

    create index(:content_pages, [:app_id])
  end
end
