# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :honeycomb_adventure,
  ecto_repos: [HoneycombAdventure.Repo]

# Configures the endpoint
config :honeycomb_adventure, HoneycombAdventureWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "feBfCnJ/qG3jTSRxVUvR0RARk0KMI3EH4uvhp3YAYlFfsGaTvW/mryHCEOQaCV8y",
  render_errors: [view: HoneycombAdventureWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HoneycombAdventure.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
