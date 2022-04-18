defmodule PortalCms.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :app_id, references(:apps, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:roles, [:app_id])
    create index(:roles, [:user_id])
  end
end
