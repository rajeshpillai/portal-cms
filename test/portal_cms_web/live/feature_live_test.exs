defmodule PortalCmsWeb.FeatureLiveTest do
  use PortalCmsWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PortalCms.Portal

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:feature) do
    {:ok, feature} = Portal.create_feature(@create_attrs)
    feature
  end

  defp create_feature(_) do
    feature = fixture(:feature)
    %{feature: feature}
  end

  describe "Index" do
    setup [:create_feature]

    test "lists all features", %{conn: conn, feature: feature} do
      {:ok, _index_live, html} = live(conn, Routes.feature_index_path(conn, :index))

      assert html =~ "Listing Features"
      assert html =~ feature.name
    end

    test "saves new feature", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.feature_index_path(conn, :index))

      assert index_live |> element("a", "New Feature") |> render_click() =~
               "New Feature"

      assert_patch(index_live, Routes.feature_index_path(conn, :new))

      assert index_live
             |> form("#feature-form", feature: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#feature-form", feature: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.feature_index_path(conn, :index))

      assert html =~ "Feature created successfully"
      assert html =~ "some name"
    end

    test "updates feature in listing", %{conn: conn, feature: feature} do
      {:ok, index_live, _html} = live(conn, Routes.feature_index_path(conn, :index))

      assert index_live |> element("#feature-#{feature.id} a", "Edit") |> render_click() =~
               "Edit Feature"

      assert_patch(index_live, Routes.feature_index_path(conn, :edit, feature))

      assert index_live
             |> form("#feature-form", feature: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#feature-form", feature: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.feature_index_path(conn, :index))

      assert html =~ "Feature updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes feature in listing", %{conn: conn, feature: feature} do
      {:ok, index_live, _html} = live(conn, Routes.feature_index_path(conn, :index))

      assert index_live |> element("#feature-#{feature.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#feature-#{feature.id}")
    end
  end

  describe "Show" do
    setup [:create_feature]

    test "displays feature", %{conn: conn, feature: feature} do
      {:ok, _show_live, html} = live(conn, Routes.feature_show_path(conn, :show, feature))

      assert html =~ "Show Feature"
      assert html =~ feature.name
    end

    test "updates feature within modal", %{conn: conn, feature: feature} do
      {:ok, show_live, _html} = live(conn, Routes.feature_show_path(conn, :show, feature))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Feature"

      assert_patch(show_live, Routes.feature_show_path(conn, :edit, feature))

      assert show_live
             |> form("#feature-form", feature: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#feature-form", feature: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.feature_show_path(conn, :show, feature))

      assert html =~ "Feature updated successfully"
      assert html =~ "some updated name"
    end
  end
end
