# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PortalCms.Repo.insert!(%PortalCms.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PortalCms.Repo
alias PortalCms.Portal.App
alias PortalCms.Portal.Navigation
require Logger

Repo.delete_all(Navigation)
Repo.delete_all(App)

result =Repo.insert!(%App{
  name: "Agent Operator Dashboard",
},returning: [:id])

IO.inspect(result.id);

Repo.insert! %Navigation{
  name: "MainNav",
  app_id: result.id
}
