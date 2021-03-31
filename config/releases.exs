import Config

config :mangaroo, cors_origin: System.fetch_env!("CORS_ORIGIN")

config :mangaroo, MangarooWeb.Endpoint,
  http: [
    port: String.to_integer(System.fetch_env!("PORT")),
    transport_options: [socket_opts: [:inet6]]
  ],
  url: [
    host: System.fetch_env!("HOST"),
    port: String.to_integer(System.fetch_env!("PORT"))
  ],
  server: true,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")

config :mangaroo, Mangaroo.Repo,
  hostname: System.fetch_env!("DB_HOSTNAME"),
  username: System.fetch_env!("DB_USERNAME"),
  password: System.fetch_env!("DB_PASSWORD"),
  database: System.fetch_env!("DB_NAME"),
  port: System.fetch_env!("DB_PORT"),
  pool_size: String.to_integer(System.fetch_env!("DB_POOL_SIZE")),
  ssl: true,
  ssl_opts: [
    cacertfile: System.fetch_env!("DB_CERT")
  ]

config :mangaroo, Mangaroo.EventStore,
  hostname: System.fetch_env!("EVENTSTORE_DB_HOSTNAME"),
  username: System.fetch_env!("EVENTSTORE_DB_USERNAME"),
  password: System.fetch_env!("EVENTSTORE_DB_PASSWORD"),
  database: System.fetch_env!("EVENTSTORE_DB_NAME"),
  port: System.fetch_env!("EVENTSTORE_DB_PORT"),
  pool_size: String.to_integer(System.fetch_env!("EVENTSTORE_DB_POOL_SIZE")),
  ssl: true,
  ssl_opts: [
    cacertfile: System.fetch_env!("EVENTSTORE_DB_CERT")
  ]
