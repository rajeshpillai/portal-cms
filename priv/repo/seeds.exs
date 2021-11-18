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
alias PortalCms.Portal.NavItem
alias PortalCms.Portal.Feature


require Logger

Repo.delete_all(Navigation)
Repo.delete_all(App)

app =Repo.insert!(%App{
  name: "Agent Operator Dashboard",
},returning: [:id])

IO.inspect(app.id)

nav_result = Repo.insert!(%Navigation{
  name: "MainNav",
  app_id: app.id,
}, returning: [:id])


Repo.insert! %NavItem{
  title: "Menu 1",
  url: "Url 1",
  seq_no: 1,
  navigation_id: nav_result.id
}

Repo.insert! %NavItem{
  title: "Menu 2",
  url: "Url 2",
  seq_no: 2,
  navigation_id: nav_result.id
}

Repo.insert! %NavItem{
  title: "Menu 3",
  url: "Url 3",
  seq_no: 3,
  navigation_id: nav_result.id
}

# Feature seed data
Repo.insert! %Feature{
  name: "agent_create",
  app_id: app.id
}

Repo.insert! %Feature{
  name: "agent_edit",
  app_id: app.id
}

Repo.insert! %Feature{
  name: "agent_delete",
  app_id: app.id
}
