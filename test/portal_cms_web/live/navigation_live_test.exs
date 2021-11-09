defmodule PortalCmsWeb.NavigationLiveTest do
  use PortalCmsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PortalCms.Portal

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:navigation) do
    {:ok, navigation} = Portal.create_navigation(@create_attrs)
    navigation
  end

  defp create_navigation(_) do
    navigation = fixture(:navigation)
    %{navigation: navigation}
  end

  describe "Index" do
    setup [:create_navigation]

    test "lists all navigations", %{conn: conn, navigation: navigation} do
      {:ok, _index_live, html} = live(conn, Routes.navigation_index_path(conn, :index))

      assert html =~ "Listing Navigations"
      assert html =~ navigation.name
    end

    test "saves new navigation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.navigation_index_path(conn, :index))

      assert index_live |> element("a", "New Navigation") |> render_click() =~
               "New Navigation"

      assert_patch(index_live, Routes.navigation_index_path(conn, :new))

      assert index_live
             |> form("#navigation-form", navigation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#navigation-form", navigation: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.navigation_index_path(conn, :index))

      assert html =~ "Navigation created successfully"
      assert html =~ "some name"
    end

    test "updates navigation in listing", %{conn: conn, navigation: navigation} do
      {:ok, index_live, _html} = live(conn, Routes.navigation_index_path(conn, :index))

      assert index_live |> element("#navigation-#{navigation.id} a", "Edit") |> render_click() =~
               "Edit Navigation"

      assert_patch(index_live, Routes.navigation_index_path(conn, :edit, navigation))

      assert index_live
             |> form("#navigation-form", navigation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#navigation-form", navigation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.navigation_index_path(conn, :index))

      assert html =~ "Navigation updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes navigation in listing", %{conn: conn, navigation: navigation} do
      {:ok, index_live, _html} = live(conn, Routes.navigation_index_path(conn, :index))

      assert index_live |> element("#navigation-#{navigation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#navigation-#{navigation.id}")
    end
  end

  describe "Show" do
    setup [:create_navigation]

    test "displays navigation", %{conn: conn, navigation: navigation} do
      {:ok, _show_live, html} = live(conn, Routes.navigation_show_path(conn, :show, navigation))

      assert html =~ "Show Navigation"
      assert html =~ navigation.name
    end

    test "updates navigation within modal", %{conn: conn, navigation: navigation} do
      {:ok, show_live, _html} = live(conn, Routes.navigation_show_path(conn, :show, navigation))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Navigation"

      assert_patch(show_live, Routes.navigation_show_path(conn, :edit, navigation))

      assert show_live
             |> form("#navigation-form", navigation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#navigation-form", navigation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.navigation_show_path(conn, :show, navigation))

      assert html =~ "Navigation updated successfully"
      assert html =~ "some updated name"
    end
  end
end
