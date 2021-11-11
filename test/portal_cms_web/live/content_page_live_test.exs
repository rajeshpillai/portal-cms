defmodule PortalCmsWeb.ContentPageLiveTest do
  use PortalCmsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PortalCms.Portal

  @create_attrs %{content: "some content", is_published: true, slug: "some slug", title: "some title"}
  @update_attrs %{content: "some updated content", is_published: false, slug: "some updated slug", title: "some updated title"}
  @invalid_attrs %{content: nil, is_published: nil, slug: nil, title: nil}

  defp fixture(:content_page) do
    {:ok, content_page} = Portal.create_content_page(@create_attrs)
    content_page
  end

  defp create_content_page(_) do
    content_page = fixture(:content_page)
    %{content_page: content_page}
  end

  describe "Index" do
    setup [:create_content_page]

    test "lists all content_pages", %{conn: conn, content_page: content_page} do
      {:ok, _index_live, html} = live(conn, Routes.content_page_index_path(conn, :index))

      assert html =~ "Listing Content pages"
      assert html =~ content_page.content
    end

    test "saves new content_page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.content_page_index_path(conn, :index))

      assert index_live |> element("a", "New Content page") |> render_click() =~
               "New Content page"

      assert_patch(index_live, Routes.content_page_index_path(conn, :new))

      assert index_live
             |> form("#content_page-form", content_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#content_page-form", content_page: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.content_page_index_path(conn, :index))

      assert html =~ "Content page created successfully"
      assert html =~ "some content"
    end

    test "updates content_page in listing", %{conn: conn, content_page: content_page} do
      {:ok, index_live, _html} = live(conn, Routes.content_page_index_path(conn, :index))

      assert index_live |> element("#content_page-#{content_page.id} a", "Edit") |> render_click() =~
               "Edit Content page"

      assert_patch(index_live, Routes.content_page_index_path(conn, :edit, content_page))

      assert index_live
             |> form("#content_page-form", content_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#content_page-form", content_page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.content_page_index_path(conn, :index))

      assert html =~ "Content page updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes content_page in listing", %{conn: conn, content_page: content_page} do
      {:ok, index_live, _html} = live(conn, Routes.content_page_index_path(conn, :index))

      assert index_live |> element("#content_page-#{content_page.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#content_page-#{content_page.id}")
    end
  end

  describe "Show" do
    setup [:create_content_page]

    test "displays content_page", %{conn: conn, content_page: content_page} do
      {:ok, _show_live, html} = live(conn, Routes.content_page_show_path(conn, :show, content_page))

      assert html =~ "Show Content page"
      assert html =~ content_page.content
    end

    test "updates content_page within modal", %{conn: conn, content_page: content_page} do
      {:ok, show_live, _html} = live(conn, Routes.content_page_show_path(conn, :show, content_page))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Content page"

      assert_patch(show_live, Routes.content_page_show_path(conn, :edit, content_page))

      assert show_live
             |> form("#content_page-form", content_page: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#content_page-form", content_page: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.content_page_show_path(conn, :show, content_page))

      assert html =~ "Content page updated successfully"
      assert html =~ "some updated content"
    end
  end
end
