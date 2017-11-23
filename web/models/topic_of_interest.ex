defmodule UserInterests.TopicOfInterest do
  use UserInterests.Web, :model

  schema "topics_of_interest" do
    field :name, :string
    field :description, :string
    many_to_many :users, UserInterests.User, join_through: "users_interests"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description, :user_id])
  end
end
