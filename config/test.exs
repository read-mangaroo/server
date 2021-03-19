use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :mangaroo, Mangaroo.Repo,
  username: "postgres",
  password: "postgres",
  database: "mangaroo_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost"

config :mangaroo, Mangaroo.EventStore,
  username: "postgres",
  password: "postgres",
  database: "mangaroo_eventstore_test",
  hostname: "localhost"

config :commanded, event_store_adapter: Commanded.EventStore.Adapters.InMemory

config :commanded, Commanded.EventStore.Adapters.InMemory,
  serializer: Commanded.Serialization.JsonSerializer

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mangaroo, MangarooWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
