defmodule PortalCms.PortalTest do
  use PortalCms.DataCase

  alias PortalCms.Portal

  describe "apps" do
    alias PortalCms.Portal.App

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def app_fixture(attrs \\ %{}) do
      {:ok, app} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portal.create_app()

      app
    end

    test "list_apps/0 returns all apps" do
      app = app_fixture()
      assert Portal.list_apps() == [app]
    end

    test "get_app!/1 returns the app with given id" do
      app = app_fixture()
      assert Portal.get_app!(app.id) == app
    end

    test "create_app/1 with valid data creates a app" do
      assert {:ok, %App{} = app} = Portal.create_app(@valid_attrs)
      assert app.name == "some name"
    end

    test "create_app/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portal.create_app(@invalid_attrs)
    end

    test "update_app/2 with valid data updates the app" do
      app = app_fixture()
      assert {:ok, %App{} = app} = Portal.update_app(app, @update_attrs)
      assert app.name == "some updated name"
    end

    test "update_app/2 with invalid data returns error changeset" do
      app = app_fixture()
      assert {:error, %Ecto.Changeset{}} = Portal.update_app(app, @invalid_attrs)
      assert app == Portal.get_app!(app.id)
    end

    test "delete_app/1 deletes the app" do
      app = app_fixture()
      assert {:ok, %App{}} = Portal.delete_app(app)
      assert_raise Ecto.NoResultsError, fn -> Portal.get_app!(app.id) end
    end

    test "change_app/1 returns a app changeset" do
      app = app_fixture()
      assert %Ecto.Changeset{} = Portal.change_app(app)
    end
  end

  describe "navigations" do
    alias PortalCms.Portal.Navigation

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def navigation_fixture(attrs \\ %{}) do
      {:ok, navigation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portal.create_navigation()

      navigation
    end

    test "list_navigations/0 returns all navigations" do
      navigation = navigation_fixture()
      assert Portal.list_navigations() == [navigation]
    end

    test "get_navigation!/1 returns the navigation with given id" do
      navigation = navigation_fixture()
      assert Portal.get_navigation!(navigation.id) == navigation
    end

    test "create_navigation/1 with valid data creates a navigation" do
      assert {:ok, %Navigation{} = navigation} = Portal.create_navigation(@valid_attrs)
      assert navigation.name == "some name"
    end

    test "create_navigation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portal.create_navigation(@invalid_attrs)
    end

    test "update_navigation/2 with valid data updates the navigation" do
      navigation = navigation_fixture()
      assert {:ok, %Navigation{} = navigation} = Portal.update_navigation(navigation, @update_attrs)
      assert navigation.name == "some updated name"
    end

    test "update_navigation/2 with invalid data returns error changeset" do
      navigation = navigation_fixture()
      assert {:error, %Ecto.Changeset{}} = Portal.update_navigation(navigation, @invalid_attrs)
      assert navigation == Portal.get_navigation!(navigation.id)
    end

    test "delete_navigation/1 deletes the navigation" do
      navigation = navigation_fixture()
      assert {:ok, %Navigation{}} = Portal.delete_navigation(navigation)
      assert_raise Ecto.NoResultsError, fn -> Portal.get_navigation!(navigation.id) end
    end

    test "change_navigation/1 returns a navigation changeset" do
      navigation = navigation_fixture()
      assert %Ecto.Changeset{} = Portal.change_navigation(navigation)
    end
  end
end
