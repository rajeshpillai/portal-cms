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
alias PortalCms.Portal.Role
alias PortalCms.Portal.Permission
alias PortalCms.Accounts.User
alias PortalCms.Portal.ContentPage
alias PortalCms.Portal.ContentBlock

require Logger

Repo.delete_all(Permission)
Repo.delete_all(Feature)
Repo.delete_all(Role)
Repo.delete_all(NavItem)
Repo.delete_all(Navigation)
Repo.delete_all(ContentPage)
Repo.delete_all(ContentBlock)
Repo.delete_all(App)
Repo.delete_all(User)

# users password:- algo@1234567
user =
  Repo.insert!(
    %User{
      email: "test@gmail.com",
      hashed_password: "$2b$12$/7pgnNn2Pwqti0KYVn886O406dRxjvHbsxXQZ8oEKoBw114wURFqO"
    },
    returning: [:id]
  )

IO.inspect(user.id, label: "user.id")

# apps
app =
  Repo.insert!(
    %App{
      name: "Tasky",
      user_id: user.id
    },
    returning: [:id]
  )

IO.inspect(app.id)

nav_result =
  Repo.insert!(
    %Navigation{
      name: "MainNav",
      app_id: app.id,
      user_id: user.id
    },
    returning: [:id]
  )

Repo.insert!(%NavItem{
  title: "Menu 1",
  url: "Url 1",
  seq_no: 1,
  navigation_id: nav_result.id,
  user_id: user.id
})

Repo.insert!(%NavItem{
  title: "Menu 2",
  url: "Url 2",
  seq_no: 2,
  navigation_id: nav_result.id,
  user_id: user.id
})

Repo.insert!(%NavItem{
  title: "Menu 3",
  url: "Url 3",
  seq_no: 3,
  navigation_id: nav_result.id,
  user_id: user.id
})

# Feature seed data

todo_feature =
  Repo.insert!(
    %Feature{
      name: "Todo",
      app_id: app.id,
      user_id: user.id
    },
    returning: [:id]
  )

comment_feature =
  Repo.insert!(
    %Feature{
      name: "Comment",
      app_id: app.id,
      user_id: user.id
    },
    returning: [:id]
  )

# Permission Seed data for features
Repo.insert!(%Permission{
  name: "add",
  feature_id: todo_feature.id,
  user_id: user.id
})

Repo.insert!(%Permission{
  name: "delete",
  feature_id: todo_feature.id,
  user_id: user.id
})

# Comment
Repo.insert!(%Permission{
  name: "addcomment",
  feature_id: comment_feature.id,
  user_id: user.id
})

Repo.insert!(%Permission{
  name: "deletecomment",
  feature_id: comment_feature.id,
  user_id: user.id
})

Repo.insert!(%Permission{
  name: "markascompleted",
  feature_id: todo_feature.id,
  user_id: user.id
})

# Role seed data
Repo.insert!(%Role{
  name: "user",
  app_id: app.id,
  user_id: user.id
})

Repo.insert!(%Role{
  name: "admin",
  app_id: app.id,
  user_id: user.id
})

Repo.insert!(%Role{
  name: "reviewer",
  app_id: app.id,
  user_id: user.id
})
