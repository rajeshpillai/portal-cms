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
end
