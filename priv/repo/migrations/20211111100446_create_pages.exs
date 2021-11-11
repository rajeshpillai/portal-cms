defmodule PortalCms.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :slug, :string
      add :content, :text
      add :is_published, :boolean, default: false, null: false
      add :app_id, references(:apps, on_delete: :nothing)

      timestamps()
    end

  end
end
