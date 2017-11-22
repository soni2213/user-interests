defmodule UserInterests.TopicOfInterestController do
  use UserInterests.Web, :controller

  alias UserInterests.TopicOfInterest

  def index(conn, _params) do
    topics_of_interest = Repo.all(TopicOfInterest)
    render(conn, "index.json", topics_of_interest: topics_of_interest)
  end

  def create(conn, %{"topic_of_interest" => topic_of_interest_params}) do
    changeset = TopicOfInterest.changeset(%TopicOfInterest{}, topic_of_interest_params)

    case Repo.insert(changeset) do
      {:ok, topic_of_interest} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", topic_of_interest_path(conn, :show, topic_of_interest))
        |> render("show.json", topic_of_interest: topic_of_interest)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(UserInterests.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic_of_interest = Repo.get!(TopicOfInterest, id)
    render(conn, "show.json", topic_of_interest: topic_of_interest)
  end

  def update(conn, %{"id" => id, "topic_of_interest" => topic_of_interest_params}) do
    topic_of_interest = Repo.get!(TopicOfInterest, id)
    changeset = TopicOfInterest.changeset(topic_of_interest, topic_of_interest_params)

    case Repo.update(changeset) do
      {:ok, topic_of_interest} ->
        render(conn, "show.json", topic_of_interest: topic_of_interest)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(UserInterests.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic_of_interest = Repo.get!(TopicOfInterest, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(topic_of_interest)

    send_resp(conn, :no_content, "")
  end
end
