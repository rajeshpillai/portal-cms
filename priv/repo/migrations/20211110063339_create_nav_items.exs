defmodule PortalCms.Repo.Migrations.CreateNavItems do
  use Ecto.Migration

  def change do
    create table(:nav_items) do
      add :title, :string
      add :url, :string
      add :navigation_id, references(:navigations, on_delete: :nothing)
      add :parent_id, references(:nav_items, on_delete: :nothing)

      timestamps()
    end

    create index(:nav_items, [:navigation_id])
    create index(:nav_items, [:parent_id])
  end
end
