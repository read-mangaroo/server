# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :mangaroo,
  ecto_repos: [Mangaroo.Repo],
  event_stores: [Mangaroo.EventStore]

# Configures the endpoint
config :mangaroo, MangarooWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5Z3JuHSjRCSD7+aw8E/dyLv/AhCC+OmPkHYZrQw+L4s5XV4M/zQtlR0o/nNwP4H4",
  render_errors: [view: MangarooWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Mangaroo.PubSub,
  live_view: [signing_salt: "hdwpbsbC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :commanded, event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections, repo: Mangaroo.Repo

config :mangaroo, Mangaroo.Commanded,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Mangaroo.EventStore
  ],
  pub_sub: :local,
  registry: :local

config :mangaroo, Mangaroo.EventStore,
  column_data_type: "jsonb",
  serializer: EventStore.JsonbSerializer,
  types: EventStore.PostgresTypes

config :cors_plug,
  max_age: 86_400,
  methods: ["GET", "POST"]

config :waffle,
  storage: Waffle.Storage.Local,
  storage_dir_prefix: "tmp/uploads"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
