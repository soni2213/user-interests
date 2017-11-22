defmodule UserInterests.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string
      add :age, :integer
      add :email, :string
      add :password, :string

      timestamps()
    end
  end
end
