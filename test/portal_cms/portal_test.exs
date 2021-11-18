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

  describe "nav_items" do
    alias PortalCms.Portal.NavItem

    @valid_attrs %{title: "some title", url: "some url"}
    @update_attrs %{title: "some updated title", url: "some updated url"}
    @invalid_attrs %{title: nil, url: nil}

    def nav_item_fixture(attrs \\ %{}) do
      {:ok, nav_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portal.create_nav_item()

      nav_item
    end

    test "list_nav_items/0 returns all nav_items" do
      nav_item = nav_item_fixture()
      assert Portal.list_nav_items() == [nav_item]
    end

    test "get_nav_item!/1 returns the nav_item with given id" do
      nav_item = nav_item_fixture()
      assert Portal.get_nav_item!(nav_item.id) == nav_item
    end

    test "create_nav_item/1 with valid data creates a nav_item" do
      assert {:ok, %NavItem{} = nav_item} = Portal.create_nav_item(@valid_attrs)
      assert nav_item.title == "some title"
      assert nav_item.url == "some url"
    end

    test "create_nav_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portal.create_nav_item(@invalid_attrs)
    end

    test "update_nav_item/2 with valid data updates the nav_item" do
      nav_item = nav_item_fixture()
      assert {:ok, %NavItem{} = nav_item} = Portal.update_nav_item(nav_item, @update_attrs)
      assert nav_item.title == "some updated title"
      assert nav_item.url == "some updated url"
    end

    test "update_nav_item/2 with invalid data returns error changeset" do
      nav_item = nav_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Portal.update_nav_item(nav_item, @invalid_attrs)
      assert nav_item == Portal.get_nav_item!(nav_item.id)
    end

    test "delete_nav_item/1 deletes the nav_item" do
      nav_item = nav_item_fixture()
      assert {:ok, %NavItem{}} = Portal.delete_nav_item(nav_item)
      assert_raise Ecto.NoResultsError, fn -> Portal.get_nav_item!(nav_item.id) end
    end

    test "change_nav_item/1 returns a nav_item changeset" do
      nav_item = nav_item_fixture()
      assert %Ecto.Changeset{} = Portal.change_nav_item(nav_item)
    end
  end

  describe "pages" do
    alias PortalCms.Portal.Page

    @valid_attrs %{content: "some content", is_published: true, slug: "some slug", title: "some title"}
    @update_attrs %{content: "some updated content", is_published: false, slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{content: nil, is_published: nil, slug: nil, title: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portal.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Portal.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Portal.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Portal.create_page(@valid_attrs)
      assert page.content == "some content"
      assert page.is_published == true
      assert page.slug == "some slug"
      assert page.title == "some title"
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portal.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, %Page{} = page} = Portal.update_page(page, @update_attrs)
      assert page.content == "some updated content"
      assert page.is_published == false
      assert page.slug == "some updated slug"
      assert page.title == "some updated title"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Portal.update_page(page, @invalid_attrs)
      assert page == Portal.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Portal.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Portal.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Portal.change_page(page)
    end
  end

  describe "content_pages" do
    alias PortalCms.Portal.ContentPage

    @valid_attrs %{content: "some content", is_published: true, slug: "some slug", title: "some title"}
    @update_attrs %{content: "some updated content", is_published: false, slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{content: nil, is_published: nil, slug: nil, title: nil}

    def content_page_fixture(attrs \\ %{}) do
      {:ok, content_page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portal.create_content_page()

      content_page
    end

    test "list_content_pages/0 returns all content_pages" do
      content_page = content_page_fixture()
      assert Portal.list_content_pages() == [content_page]
    end

    test "get_content_page!/1 returns the content_page with given id" do
      content_page = content_page_fixture()
      assert Portal.get_content_page!(content_page.id) == content_page
    end

    test "create_content_page/1 with valid data creates a content_page" do
      assert {:ok, %ContentPage{} = content_page} = Portal.create_content_page(@valid_attrs)
      assert content_page.content == "some content"
      assert content_page.is_published == true
      assert content_page.slug == "some slug"
      assert content_page.title == "some title"
    end

    test "create_content_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portal.create_content_page(@invalid_attrs)
    end

    test "update_content_page/2 with valid data updates the content_page" do
      content_page = content_page_fixture()
      assert {:ok, %ContentPage{} = content_page} = Portal.update_content_page(content_page, @update_attrs)
      assert content_page.content == "some updated content"
      assert content_page.is_published == false
      assert content_page.slug == "some updated slug"
      assert content_page.title == "some updated title"
    end

    test "update_content_page/2 with invalid data returns error changeset" do
      content_page = content_page_fixture()
      assert {:error, %Ecto.Changeset{}} = Portal.update_content_page(content_page, @invalid_attrs)
      assert content_page == Portal.get_content_page!(content_page.id)
    end

    test "delete_content_page/1 deletes the content_page" do
      content_page = content_page_fixture()
      assert {:ok, %ContentPage{}} = Portal.delete_content_page(content_page)
      assert_raise Ecto.NoResultsError, fn -> Portal.get_content_page!(content_page.id) end
    end

    test "change_content_page/1 returns a content_page changeset" do
      content_page = content_page_fixture()
      assert %Ecto.Changeset{} = Portal.change_content_page(content_page)
    end
  end

  describe "features" do
    alias PortalCms.Portal.Feature

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def feature_fixture(attrs \\ %{}) do
      {:ok, feature} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portal.create_feature()

      feature
    end

    test "list_features/0 returns all features" do
      feature = feature_fixture()
      assert Portal.list_features() == [feature]
    end

    test "get_feature!/1 returns the feature with given id" do
      feature = feature_fixture()
      assert Portal.get_feature!(feature.id) == feature
    end

    test "create_feature/1 with valid data creates a feature" do
      assert {:ok, %Feature{} = feature} = Portal.create_feature(@valid_attrs)
      assert feature.name == "some name"
    end

    test "create_feature/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portal.create_feature(@invalid_attrs)
    end

    test "update_feature/2 with valid data updates the feature" do
      feature = feature_fixture()
      assert {:ok, %Feature{} = feature} = Portal.update_feature(feature, @update_attrs)
      assert feature.name == "some updated name"
    end

    test "update_feature/2 with invalid data returns error changeset" do
      feature = feature_fixture()
      assert {:error, %Ecto.Changeset{}} = Portal.update_feature(feature, @invalid_attrs)
      assert feature == Portal.get_feature!(feature.id)
    end

    test "delete_feature/1 deletes the feature" do
      feature = feature_fixture()
      assert {:ok, %Feature{}} = Portal.delete_feature(feature)
      assert_raise Ecto.NoResultsError, fn -> Portal.get_feature!(feature.id) end
    end

    test "change_feature/1 returns a feature changeset" do
      feature = feature_fixture()
      assert %Ecto.Changeset{} = Portal.change_feature(feature)
    end
  end
end
