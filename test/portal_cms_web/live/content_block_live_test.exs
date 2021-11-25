defmodule PortalCmsWeb.ContentBlockLiveTest do
  use PortalCmsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PortalCms.Portal

  @create_attrs %{content: "some content", is_published: true, type: "some type"}
  @update_attrs %{content: "some updated content", is_published: false, type: "some updated type"}
  @invalid_attrs %{content: nil, is_published: nil, type: nil}

  defp fixture(:content_block) do
    {:ok, content_block} = Portal.create_content_block(@create_attrs)
    content_block
  end

  defp create_content_block(_) do
    content_block = fixture(:content_block)
    %{content_block: content_block}
  end

  describe "Index" do
    setup [:create_content_block]

    test "lists all content_blocks", %{conn: conn, content_block: content_block} do
      {:ok, _index_live, html} = live(conn, Routes.content_block_index_path(conn, :index))

      assert html =~ "Listing Content blocks"
      assert html =~ content_block.content
    end

    test "saves new content_block", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.content_block_index_path(conn, :index))

      assert index_live |> element("a", "New Content block") |> render_click() =~
               "New Content block"

      assert_patch(index_live, Routes.content_block_index_path(conn, :new))

      assert index_live
             |> form("#content_block-form", content_block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#content_block-form", content_block: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.content_block_index_path(conn, :index))

      assert html =~ "Content block created successfully"
      assert html =~ "some content"
    end

    test "updates content_block in listing", %{conn: conn, content_block: content_block} do
      {:ok, index_live, _html} = live(conn, Routes.content_block_index_path(conn, :index))

      assert index_live |> element("#content_block-#{content_block.id} a", "Edit") |> render_click() =~
               "Edit Content block"

      assert_patch(index_live, Routes.content_block_index_path(conn, :edit, content_block))

      assert index_live
             |> form("#content_block-form", content_block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#content_block-form", content_block: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.content_block_index_path(conn, :index))

      assert html =~ "Content block updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes content_block in listing", %{conn: conn, content_block: content_block} do
      {:ok, index_live, _html} = live(conn, Routes.content_block_index_path(conn, :index))

      assert index_live |> element("#content_block-#{content_block.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#content_block-#{content_block.id}")
    end
  end

  describe "Show" do
    setup [:create_content_block]

    test "displays content_block", %{conn: conn, content_block: content_block} do
      {:ok, _show_live, html} = live(conn, Routes.content_block_show_path(conn, :show, content_block))

      assert html =~ "Show Content block"
      assert html =~ content_block.content
    end

    test "updates content_block within modal", %{conn: conn, content_block: content_block} do
      {:ok, show_live, _html} = live(conn, Routes.content_block_show_path(conn, :show, content_block))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Content block"

      assert_patch(show_live, Routes.content_block_show_path(conn, :edit, content_block))

      assert show_live
             |> form("#content_block-form", content_block: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#content_block-form", content_block: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.content_block_show_path(conn, :show, content_block))

      assert html =~ "Content block updated successfully"
      assert html =~ "some updated content"
    end
  end
end
