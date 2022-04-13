defmodule PortalCms.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :title, :string
      add :slug, :string
      add :content, :text
      add :is_published, :boolean, default: false, null: false
      add :app_id, references(:apps, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:pages, [:user_id])
  end
end
