defmodule UserInterests.Router do
  use UserInterests.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    resources "/users", UserController # for user actions.
    resources "/topics_of_interest", TopicOfInterestController # for topic of interests.
  end

  scope "/", UserInterests do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  scope "/api", UserInterests do
    pipe_through :api
    resources "/users", UserController
  end
  # Other scopes may use custom stacks.
  # scope "/api", UserInterests do
  #   pipe_through :api
  # end
end
