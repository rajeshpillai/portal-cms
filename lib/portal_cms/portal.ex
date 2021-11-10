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
  def get_app!(id), do: Repo.get!(App, id)

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
    q = from p in NavItem, where: p.navigation_id == ^nav_id
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
end
