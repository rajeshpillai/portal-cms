defmodule PortalCms.Repo.Migrations.CreateNavigations do
  use Ecto.Migration

  def change do
    create table(:navigations) do
      add :name, :string
      add :app_id, references(:apps, on_delete: :nothing)

      timestamps()
    end

    create index(:navigations, [:app_id])
  end
end
