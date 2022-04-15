defmodule PortalCms.UserRolesContextTest do
  use PortalCms.DataCase

  alias PortalCms.UserRolesContext

  describe "userroles" do
    alias PortalCms.UserRolesContext.UserRole

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_role_fixture(attrs \\ %{}) do
      {:ok, user_role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserRolesContext.create_user_role()

      user_role
    end

    test "list_userroles/0 returns all userroles" do
      user_role = user_role_fixture()
      assert UserRolesContext.list_userroles() == [user_role]
    end

    test "get_user_role!/1 returns the user_role with given id" do
      user_role = user_role_fixture()
      assert UserRolesContext.get_user_role!(user_role.id) == user_role
    end

    test "create_user_role/1 with valid data creates a user_role" do
      assert {:ok, %UserRole{} = user_role} = UserRolesContext.create_user_role(@valid_attrs)
    end

    test "create_user_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserRolesContext.create_user_role(@invalid_attrs)
    end

    test "update_user_role/2 with valid data updates the user_role" do
      user_role = user_role_fixture()
      assert {:ok, %UserRole{} = user_role} = UserRolesContext.update_user_role(user_role, @update_attrs)
    end

    test "update_user_role/2 with invalid data returns error changeset" do
      user_role = user_role_fixture()
      assert {:error, %Ecto.Changeset{}} = UserRolesContext.update_user_role(user_role, @invalid_attrs)
      assert user_role == UserRolesContext.get_user_role!(user_role.id)
    end

    test "delete_user_role/1 deletes the user_role" do
      user_role = user_role_fixture()
      assert {:ok, %UserRole{}} = UserRolesContext.delete_user_role(user_role)
      assert_raise Ecto.NoResultsError, fn -> UserRolesContext.get_user_role!(user_role.id) end
    end

    test "change_user_role/1 returns a user_role changeset" do
      user_role = user_role_fixture()
      assert %Ecto.Changeset{} = UserRolesContext.change_user_role(user_role)
    end
  end
end
