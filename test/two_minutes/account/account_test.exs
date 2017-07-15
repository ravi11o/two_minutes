defmodule TwoMinutes.AccountTest do
  use TwoMinutes.DataCase

  alias TwoMinutes.Account

  describe "users" do
    alias TwoMinutes.Account.User

    @valid_attrs %{avatar: "some avatar", email: "some email", hashed_password: "some hashed_password", is_admin: true, name: "some name", provider: "some provider", verified: true}
    @update_attrs %{avatar: "some updated avatar", email: "some updated email", hashed_password: "some updated hashed_password", is_admin: false, name: "some updated name", provider: "some updated provider", verified: false}
    @invalid_attrs %{avatar: nil, email: nil, hashed_password: nil, is_admin: nil, name: nil, provider: nil, verified: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.email == "some email"
      assert user.hashed_password == "some hashed_password"
      assert user.is_admin == true
      assert user.name == "some name"
      assert user.provider == "some provider"
      assert user.verified == true
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Account.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.avatar == "some updated avatar"
      assert user.email == "some updated email"
      assert user.hashed_password == "some updated hashed_password"
      assert user.is_admin == false
      assert user.name == "some updated name"
      assert user.provider == "some updated provider"
      assert user.verified == false
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
