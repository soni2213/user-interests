defmodule UserInterests.UserInterest do
  use UserInterests.Web, :model

  schema "users_interests" do
    belongs_to :topic_of_interest, UserInterests.TopicOfInterest
    belongs_to :user, UserInterests.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :topic_of_interest_id])
    |> validate_required([:user_id, :topic_of_interest_id])
  end
end
