defmodule PortalCms.Repo.Migrations.CreateApps do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:apps, [:user_id])
  end
end
