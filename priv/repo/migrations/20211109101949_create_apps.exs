defmodule PortalCms.Repo.Migrations.CreateApps do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :name, :string

      timestamps()
    end

  end
end
