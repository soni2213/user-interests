defmodule UserInterests.TopicOfInterestTest do
  use UserInterests.ModelCase

  alias UserInterests.TopicOfInterest

  @valid_attrs %{description: "some description", name: "some name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TopicOfInterest.changeset(%TopicOfInterest{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TopicOfInterest.changeset(%TopicOfInterest{}, @invalid_attrs)
    refute changeset.valid?
  end
end
