defmodule PortalCms.Portal do
  @moduledoc """
  The Portal context.
  """

  import Ecto.Query, warn: false
  alias PortalCms.Repo

  alias PortalCms.Portal.App

  @doc """
  Returns the list of apps.

  ## Examples

      iex> list_apps()
      [%App{}, ...]

  """
  def list_apps do
    Repo.all(App)
  end

  @doc """
  Gets a single app.

  Raises `Ecto.NoResultsError` if the App does not exist.

  ## Examples

      iex> get_app!(123)
      %App{}

      iex> get_app!(456)
      ** (Ecto.NoResultsError)

  """
  def get_app!(id)  do
    IO.puts("Fetching app for ID #{id}")
    Repo.get!(App, id)
  end

  @doc """
  Creates a app.

  ## Examples

      iex> create_app(%{field: value})
      {:ok, %App{}}

      iex> create_app(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_app(attrs \\ %{}) do
    %App{}
    |> App.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a app.

  ## Examples

      iex> update_app(app, %{field: new_value})
      {:ok, %App{}}

      iex> update_app(app, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_app(%App{} = app, attrs) do
    app
    |> App.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a app.

  ## Examples

      iex> delete_app(app)
      {:ok, %App{}}

      iex> delete_app(app)
      {:error, %Ecto.Changeset{}}

  """
  def delete_app(%App{} = app) do
    Repo.delete(app)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking app changes.

  ## Examples

      iex> change_app(app)
      %Ecto.Changeset{data: %App{}}

  """
  def change_app(%App{} = app, attrs \\ %{}) do
    App.changeset(app, attrs)
  end

  alias PortalCms.Portal.Navigation

  @doc """
  Returns the list of navigations.

  ## Examples

      iex> list_navigations()
      [%Navigation{}, ...]

  """
  def list_navigations do
    Repo.all(Navigation)
  end

  @doc """
  Gets a single navigation.

  Raises `Ecto.NoResultsError` if the Navigation does not exist.

  ## Examples

      iex> get_navigation!(123)
      %Navigation{}

      iex> get_navigation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_navigation!(id), do: Repo.get!(Navigation, id)

  def get_navigation_with_app!(id) do
    Repo.get!(Navigation, id)
      |> Repo.preload(:app)
  end

  @doc """
  Creates a navigation.

  ## Examples

      iex> create_navigation(%{field: value})
      {:ok, %Navigation{}}

      iex> create_navigation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_navigation(attrs \\ %{}) do
    %Navigation{}
    |> Navigation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a navigation.

  ## Examples

      iex> update_navigation(navigation, %{field: new_value})
      {:ok, %Navigation{}}

      iex> update_navigation(navigation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_navigation(%Navigation{} = navigation, attrs) do
    navigation
    |> Navigation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a navigation.

  ## Examples

      iex> delete_navigation(navigation)
      {:ok, %Navigation{}}

      iex> delete_navigation(navigation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_navigation(%Navigation{} = navigation) do
    Repo.delete(navigation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking navigation changes.

  ## Examples

      iex> change_navigation(navigation)
      %Ecto.Changeset{data: %Navigation{}}

  """
  def change_navigation(%Navigation{} = navigation, attrs \\ %{}) do
    Navigation.changeset(navigation, attrs)
  end

  alias PortalCms.Portal.NavItem

  @doc """
  Returns the list of nav_items.

  ## Examples

      iex> list_nav_items()
      [%NavItem{}, ...]

  """
  def list_nav_items do
    Repo.all(NavItem)
  end

  def list_nav_items(nav_id) do
    q = from p in NavItem, where: p.navigation_id == ^nav_id, order_by: p.seq_no
    Repo.all(q)

  end


  @doc """
  Gets a single nav_item.

  Raises `Ecto.NoResultsError` if the Nav item does not exist.

  ## Examples

      iex> get_nav_item!(123)
      %NavItem{}

      iex> get_nav_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nav_item!(id), do: Repo.get!(NavItem, id)

  @doc """
  Creates a nav_item.

  ## Examples

      iex> create_nav_item(%{field: value})
      {:ok, %NavItem{}}

      iex> create_nav_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nav_item(attrs \\ %{}) do
    IO.inspect( attrs )

    %NavItem{}
    |> NavItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nav_item.

  ## Examples

      iex> update_nav_item(nav_item, %{field: new_value})
      {:ok, %NavItem{}}

      iex> update_nav_item(nav_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nav_item(%NavItem{} = nav_item, attrs) do
    nav_item
    |> NavItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nav_item.

  ## Examples

      iex> delete_nav_item(nav_item)
      {:ok, %NavItem{}}

      iex> delete_nav_item(nav_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nav_item(%NavItem{} = nav_item) do
    Repo.delete(nav_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nav_item changes.

  ## Examples

      iex> change_nav_item(nav_item)
      %Ecto.Changeset{data: %NavItem{}}

  """
  def change_nav_item(%NavItem{} = nav_item, attrs \\ %{}) do
    NavItem.changeset(nav_item, attrs)
  end


  alias PortalCms.Portal.ContentPage

  @doc """
  Returns the list of content_pages.

  ## Examples

      iex> list_content_pages()
      [%ContentPage{}, ...]

  """
  def list_content_pages do
    Repo.all(ContentPage)
  end

  @doc """
  Gets a single content_page.

  Raises `Ecto.NoResultsError` if the Content page does not exist.

  ## Examples

      iex> get_content_page!(123)
      %ContentPage{}

      iex> get_content_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_content_page!(id), do: Repo.get!(ContentPage, id)

  @doc """
  Creates a content_page.

  ## Examples

      iex> create_content_page(%{field: value})
      {:ok, %ContentPage{}}

      iex> create_content_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_page(attrs \\ %{}) do
    %ContentPage{}
    |> ContentPage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a content_page.

  ## Examples

      iex> update_content_page(content_page, %{field: new_value})
      {:ok, %ContentPage{}}

      iex> update_content_page(content_page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_page(%ContentPage{} = content_page, attrs) do
    content_page
    |> ContentPage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a content_page.

  ## Examples

      iex> delete_content_page(content_page)
      {:ok, %ContentPage{}}

      iex> delete_content_page(content_page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_page(%ContentPage{} = content_page) do
    Repo.delete(content_page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_page changes.

  ## Examples

      iex> change_content_page(content_page)
      %Ecto.Changeset{data: %ContentPage{}}

  """
  def change_content_page(%ContentPage{} = content_page, attrs \\ %{}) do
    ContentPage.changeset(content_page, attrs)
  end

  alias PortalCms.Portal.Feature

  @doc """
  Returns the list of features.

  ## Examples

      iex> list_features()
      [%Feature{}, ...]

  """
  def list_features do
    Repo.all(Feature)
  end

  def list_features(app_id) do
    q = from p in Feature, where: p.app_id == ^app_id
    Repo.all(q)
  end


  @doc """
  Gets a single feature.

  Raises `Ecto.NoResultsError` if the Feature does not exist.

  ## Examples

      iex> get_feature!(123)
      %Feature{}

      iex> get_feature!(456)
      ** (Ecto.NoResultsError)

  """
  def get_feature!(id), do: Repo.get!(Feature, id)

  @doc """
  Creates a feature.

  ## Examples

      iex> create_feature(%{field: value})
      {:ok, %Feature{}}

      iex> create_feature(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_feature(attrs \\ %{}) do
    %Feature{}
    |> Feature.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a feature.

  ## Examples

      iex> update_feature(feature, %{field: new_value})
      {:ok, %Feature{}}

      iex> update_feature(feature, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_feature(%Feature{} = feature, attrs) do
    feature
    |> Feature.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a feature.

  ## Examples

      iex> delete_feature(feature)
      {:ok, %Feature{}}

      iex> delete_feature(feature)
      {:error, %Ecto.Changeset{}}

  """
  def delete_feature(%Feature{} = feature) do
    Repo.delete(feature)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking feature changes.

  ## Examples

      iex> change_feature(feature)
      %Ecto.Changeset{data: %Feature{}}

  """
  def change_feature(%Feature{} = feature, attrs \\ %{}) do
    Feature.changeset(feature, attrs)
  end

  alias PortalCms.Portal.Role

  @doc """
  Returns the list of roles.

  ## Examples

      iex> list_roles()
      [%Role{}, ...]

  """
  def list_roles do
    Repo.all(Role)
  end

  def list_roles(app_id) do
    q = from p in Role, where: p.app_id == ^app_id
    Repo.all(q)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  alias PortalCms.Portal.ContentBlock

  @doc """
  Returns the list of content_blocks.

  ## Examples

      iex> list_content_blocks()
      [%ContentBlock{}, ...]

  """
  def list_content_blocks do
    Repo.all(ContentBlock)
  end

  @doc """
  Gets a single content_block.

  Raises `Ecto.NoResultsError` if the Content block does not exist.

  ## Examples

      iex> get_content_block!(123)
      %ContentBlock{}

      iex> get_content_block!(456)
      ** (Ecto.NoResultsError)

  """
  def get_content_block!(id), do: Repo.get!(ContentBlock, id)

  @doc """
  Creates a content_block.

  ## Examples

      iex> create_content_block(%{field: value})
      {:ok, %ContentBlock{}}

      iex> create_content_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_content_block(attrs \\ %{}) do
    %ContentBlock{}
    |> ContentBlock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a content_block.

  ## Examples

      iex> update_content_block(content_block, %{field: new_value})
      {:ok, %ContentBlock{}}

      iex> update_content_block(content_block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_content_block(%ContentBlock{} = content_block, attrs) do
    content_block
    |> ContentBlock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a content_block.

  ## Examples

      iex> delete_content_block(content_block)
      {:ok, %ContentBlock{}}

      iex> delete_content_block(content_block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_content_block(%ContentBlock{} = content_block) do
    Repo.delete(content_block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking content_block changes.

  ## Examples

      iex> change_content_block(content_block)
      %Ecto.Changeset{data: %ContentBlock{}}

  """
  def change_content_block(%ContentBlock{} = content_block, attrs \\ %{}) do
    ContentBlock.changeset(content_block, attrs)
  end
end
