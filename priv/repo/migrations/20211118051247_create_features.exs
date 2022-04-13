defmodule PortalCms.Repo.Migrations.CreateFeatures do
  use Ecto.Migration

  def change do
    create table(:features) do
      add :name, :string
      add :app_id, references(:apps, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:features, [:app_id])
    create index(:features, [:user_id])
  end
end
