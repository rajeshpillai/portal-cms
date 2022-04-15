defmodule PortalCmsWeb.UserRoleLiveTest do
  use PortalCmsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PortalCms.UserRolesContext

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:user_role) do
    {:ok, user_role} = UserRolesContext.create_user_role(@create_attrs)
    user_role
  end

  defp create_user_role(_) do
    user_role = fixture(:user_role)
    %{user_role: user_role}
  end

  describe "Index" do
    setup [:create_user_role]

    test "lists all userroles", %{conn: conn, user_role: user_role} do
      {:ok, _index_live, html} = live(conn, Routes.user_role_index_path(conn, :index))

      assert html =~ "Listing Userroles"
    end

    test "saves new user_role", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.user_role_index_path(conn, :index))

      assert index_live |> element("a", "New User role") |> render_click() =~
               "New User role"

      assert_patch(index_live, Routes.user_role_index_path(conn, :new))

      assert index_live
             |> form("#user_role-form", user_role: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_role-form", user_role: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_role_index_path(conn, :index))

      assert html =~ "User role created successfully"
    end

    test "updates user_role in listing", %{conn: conn, user_role: user_role} do
      {:ok, index_live, _html} = live(conn, Routes.user_role_index_path(conn, :index))

      assert index_live |> element("#user_role-#{user_role.id} a", "Edit") |> render_click() =~
               "Edit User role"

      assert_patch(index_live, Routes.user_role_index_path(conn, :edit, user_role))

      assert index_live
             |> form("#user_role-form", user_role: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_role-form", user_role: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_role_index_path(conn, :index))

      assert html =~ "User role updated successfully"
    end

    test "deletes user_role in listing", %{conn: conn, user_role: user_role} do
      {:ok, index_live, _html} = live(conn, Routes.user_role_index_path(conn, :index))

      assert index_live |> element("#user_role-#{user_role.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_role-#{user_role.id}")
    end
  end

  describe "Show" do
    setup [:create_user_role]

    test "displays user_role", %{conn: conn, user_role: user_role} do
      {:ok, _show_live, html} = live(conn, Routes.user_role_show_path(conn, :show, user_role))

      assert html =~ "Show User role"
    end

    test "updates user_role within modal", %{conn: conn, user_role: user_role} do
      {:ok, show_live, _html} = live(conn, Routes.user_role_show_path(conn, :show, user_role))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User role"

      assert_patch(show_live, Routes.user_role_show_path(conn, :edit, user_role))

      assert show_live
             |> form("#user_role-form", user_role: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#user_role-form", user_role: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_role_show_path(conn, :show, user_role))

      assert html =~ "User role updated successfully"
    end
  end
end
