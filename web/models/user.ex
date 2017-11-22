defmodule UserInterests.User do
  use UserInterests.Web, :model

  schema "users" do
    field :full_name, :string
    field :age, :integer
    field :email, :string
    field :password, :string
    many_to_many :interests, UserInterests.TopicOfInterest, join_through: "users_interests"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:full_name, :age, :email, :password])
    |> validate_required([:full_name, :age, :email, :password])
  end
end
