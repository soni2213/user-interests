defmodule UserInterests.UserView do
  use UserInterests.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserInterests.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserInterests.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      full_name: user.full_name,
      age: user.age,
      email: user.email,
      password: user.password}
  end
end
