defmodule UserInterests.UserTest do
  use UserInterests.ModelCase

  alias UserInterests.User

  @valid_attrs %{age: 42, email: "some email", full_name: "some full_name", password: "some password"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
