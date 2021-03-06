# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :user_interests,
  ecto_repos: [UserInterests.Repo]

# Configures the endpoint
config :user_interests, UserInterests.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5Aj+1aK4+10YB8v2MzHaoVj2XXODnV0nYui6F3/as7boA3byi2gcbhw/HHfhxIqB",
  render_errors: [view: UserInterests.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UserInterests.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :guardian, Guardian,
  issuer: "UserInterests",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: "jfgrijdledbffrofrgvdbnfokjhkjjlk",
  serializer: UserInterests.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
