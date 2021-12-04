defmodule PortalCms.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :name, :string
      add :feature_id, references(:features, on_delete: :nothing)

      timestamps()
    end

    create index(:permissions, [:feature_id])
  end
end
