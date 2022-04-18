defmodule PortalCms.Repo.Migrations.CreatePermissions do
  use Ecto.Migration

  def change do
    create table(:permissions) do
      add :name, :string
      add :feature_id, references(:features, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:permissions, [:feature_id])
    create index(:permissions, [:user_id])
  end
end
