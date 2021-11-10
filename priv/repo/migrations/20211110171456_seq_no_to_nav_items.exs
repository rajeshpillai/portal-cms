defmodule PortalCms.Repo.Migrations.SeqNoToNavItems do
  use Ecto.Migration

  def change do
    alter table("nav_items") do
      add :seq_no, :integer
    end
  end
end
