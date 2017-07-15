# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :two_minutes,
  ecto_repos: [TwoMinutes.Repo]

# Configures the endpoint
config :two_minutes, TwoMinutes.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tpYFaXfNkMKSpWxvO+JiqersNlbClyp9hc9dvnobN0v84UuzLEF5lg0rL1qEp5C+",
  render_errors: [view: TwoMinutes.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TwoMinutes.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Cloudex
config :cloudex,
    api_key: System.get_env("CLOUDEX_API_KEY"),
    secret: System.get_env("CLOUDEX_API_SECRET"),
    cloud_name: System.get_env("CLOUD_NAME")


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
