defmodule UserInterests.TopicOfInterestControllerTest do
  use UserInterests.ConnCase

  alias UserInterests.TopicOfInterest
  @valid_attrs %{description: "some description", name: "some name"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, topic_of_interest_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    topic_of_interest = Repo.insert! %TopicOfInterest{}
    conn = get conn, topic_of_interest_path(conn, :show, topic_of_interest)
    assert json_response(conn, 200)["data"] == %{"id" => topic_of_interest.id,
      "name" => topic_of_interest.name,
      "description" => topic_of_interest.description}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, topic_of_interest_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, topic_of_interest_path(conn, :create), topic_of_interest: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(TopicOfInterest, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, topic_of_interest_path(conn, :create), topic_of_interest: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    topic_of_interest = Repo.insert! %TopicOfInterest{}
    conn = put conn, topic_of_interest_path(conn, :update, topic_of_interest), topic_of_interest: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TopicOfInterest, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    topic_of_interest = Repo.insert! %TopicOfInterest{}
    conn = put conn, topic_of_interest_path(conn, :update, topic_of_interest), topic_of_interest: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    topic_of_interest = Repo.insert! %TopicOfInterest{}
    conn = delete conn, topic_of_interest_path(conn, :delete, topic_of_interest)
    assert response(conn, 204)
    refute Repo.get(TopicOfInterest, topic_of_interest.id)
  end
end
