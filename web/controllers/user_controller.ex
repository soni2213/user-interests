defmodule UserInterests.UserController do
  use UserInterests.Web, :controller
  alias UserInterests.{User, SessionView, ChangesetView, UserInterest, UserView, TopicOfInterest, TopicOfInterestView }

  def create(conn, params) do
    changeset = User.registration_changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
        jwt = Guardian.Plug.current_token(new_conn)
        new_conn
        |> put_status(:created)
        |> render(SessionView, "show.json", user: user, jwt: jwt)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChangesetView, "error.json", changeset: changeset)
    end
  end


  def add_interest(conn, params) do
    # IEx.pry
    interest_params = %{topic_of_interest_id: params["interest_id"], user_id: conn.assigns.user.id}
    changeset = UserInterest.changeset(%UserInterest{}, interest_params)
    case Repo.insert(changeset) do
      {:ok, interest} ->
        conn
        |> put_status(:created)
        |> render("show_interest.json", interest: interest)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, _params) do
    query = from ui in UserInterest,
              where: ui.user_id == ^conn.assigns.user.id,
              select: ui.topic_of_interest_id
    interest_ids = Repo.all(query)
    topics_of_interest = TopicOfInterest |> where([t], t.id in ^interest_ids) |> Repo.all
    render(conn, TopicOfInterestView, "index.json", topics_of_interest: topics_of_interest)
  end
end
