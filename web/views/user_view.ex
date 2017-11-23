defmodule UserInterests.UserView do
  use UserInterests.Web, :view
  alias UserInterests.{Repo, TopicOfInterest}
  require IEx

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserInterests.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserInterests.UserView, "user.json")}
  end

  def render("show_interests.json", %{interests: interests}) do
    %{data: render_many(interests, UserInterests.UserView, "interest.json")}
  end

  def render("interest.json", %{interest: interest}) do
    %{id: interest.id,
      name: interest.name,
      description: interest.description}
  end

  def render("show_interest.json", %{interest: interest}) do
    topic_of_interest = Repo.get!(TopicOfInterest, interest.topic_of_interest_id)
    %{id: interest.id,
      name: topic_of_interest.name,
      description: topic_of_interest.description}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      full_name: user.full_name,
      age: user.age,
      email: user.email,
      password: user.password}
  end

end
