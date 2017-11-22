defmodule UserInterests.Repo.Migrations.CreateTopicOfInterest do
  use Ecto.Migration

  def change do
    create table(:topics_of_interest) do
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end
