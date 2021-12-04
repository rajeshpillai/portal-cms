defmodule PortalCmsWeb.PermissionLiveTest do
  use PortalCmsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PortalCms.Portal

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:permission) do
    {:ok, permission} = Portal.create_permission(@create_attrs)
    permission
  end

  defp create_permission(_) do
    permission = fixture(:permission)
    %{permission: permission}
  end

  describe "Index" do
    setup [:create_permission]

    test "lists all permissions", %{conn: conn, permission: permission} do
      {:ok, _index_live, html} = live(conn, Routes.permission_index_path(conn, :index))

      assert html =~ "Listing Permissions"
      assert html =~ permission.name
    end

    test "saves new permission", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.permission_index_path(conn, :index))

      assert index_live |> element("a", "New Permission") |> render_click() =~
               "New Permission"

      assert_patch(index_live, Routes.permission_index_path(conn, :new))

      assert index_live
             |> form("#permission-form", permission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#permission-form", permission: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.permission_index_path(conn, :index))

      assert html =~ "Permission created successfully"
      assert html =~ "some name"
    end

    test "updates permission in listing", %{conn: conn, permission: permission} do
      {:ok, index_live, _html} = live(conn, Routes.permission_index_path(conn, :index))

      assert index_live |> element("#permission-#{permission.id} a", "Edit") |> render_click() =~
               "Edit Permission"

      assert_patch(index_live, Routes.permission_index_path(conn, :edit, permission))

      assert index_live
             |> form("#permission-form", permission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#permission-form", permission: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.permission_index_path(conn, :index))

      assert html =~ "Permission updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes permission in listing", %{conn: conn, permission: permission} do
      {:ok, index_live, _html} = live(conn, Routes.permission_index_path(conn, :index))

      assert index_live |> element("#permission-#{permission.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#permission-#{permission.id}")
    end
  end

  describe "Show" do
    setup [:create_permission]

    test "displays permission", %{conn: conn, permission: permission} do
      {:ok, _show_live, html} = live(conn, Routes.permission_show_path(conn, :show, permission))

      assert html =~ "Show Permission"
      assert html =~ permission.name
    end

    test "updates permission within modal", %{conn: conn, permission: permission} do
      {:ok, show_live, _html} = live(conn, Routes.permission_show_path(conn, :show, permission))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Permission"

      assert_patch(show_live, Routes.permission_show_path(conn, :edit, permission))

      assert show_live
             |> form("#permission-form", permission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#permission-form", permission: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.permission_show_path(conn, :show, permission))

      assert html =~ "Permission updated successfully"
      assert html =~ "some updated name"
    end
  end
end
