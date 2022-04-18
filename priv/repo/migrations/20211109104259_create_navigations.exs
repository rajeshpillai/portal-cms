defmodule PortalCms.Repo.Migrations.CreateNavigations do
  use Ecto.Migration

  def change do
    create table(:navigations) do
      add :name, :string
      add :app_id, references(:apps, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:navigations, [:app_id])
    create index(:navigations, [:user_id])
  end
end
