defmodule PortalCms.Repo.Migrations.CreateUserroles do
  use Ecto.Migration

  def change do
    create table(:userroles) do
      add :user_id, references(:users, on_delete: :nothing)
      add :role_id, references(:roles, on_delete: :nothing)
      add :app_id, references(:apps, on_delete: :nothing)

      timestamps()
    end

    create index(:userroles, [:user_id])
    create index(:userroles, [:role_id])
    create index(:userroles, [:app_id])
  end
end
