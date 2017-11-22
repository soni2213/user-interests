defmodule UserInterests.TopicOfInterestView do
  use UserInterests.Web, :view

  def render("index.json", %{topics_of_interest: topics_of_interest}) do
    %{data: render_many(topics_of_interest, UserInterests.TopicOfInterestView, "topic_of_interest.json")}
  end

  def render("show.json", %{topic_of_interest: topic_of_interest}) do
    %{data: render_one(topic_of_interest, UserInterests.TopicOfInterestView, "topic_of_interest.json")}
  end

  def render("topic_of_interest.json", %{topic_of_interest: topic_of_interest}) do
    %{id: topic_of_interest.id,
      name: topic_of_interest.name,
      description: topic_of_interest.description}
  end
end
