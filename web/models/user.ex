defmodule UserInterests.User do
  use UserInterests.Web, :model

  schema "users" do
    field :full_name, :string
    field :age, :integer
    field :email, :string
    field :password , :string
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
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 6, max: 100)
    |> password_hash()
  end

  defp password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Comeonin.Bcrypt.hashpwsalt(password))
        _ ->
          changeset
    end
  end
end
