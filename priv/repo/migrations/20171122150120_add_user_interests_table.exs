defmodule UserInterests.Repo.Migrations.AddUserInterestsTable do
  use Ecto.Migration

  def change do
    create table(:users_interests) do
      add :user_id, references(:users)
      add :topic_of_interest_id, references(:topics_of_interest)
      timestamps()
    end
  end
end
