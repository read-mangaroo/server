defmodule Mangaroo.MixProject do
  use Mix.Project

  def project do
    [
      app: :mangaroo,
      version: "0.1.0",
      elixir: "1.11.3",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      releases: [
        mangaroo: [
          include_erts: true,
          include_executables_for: [:unix],
          applications: [
            runtime_tools: :permanent
          ]
        ]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Mangaroo.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "1.5.8"},
      {:phoenix_ecto, "4.2.1"},
      {:ecto_sql, "3.5.4"},
      {:postgrex, "0.15.8"},
      {:phoenix_live_dashboard, "0.4.0"},
      {:telemetry_metrics, "0.6.0"},
      {:telemetry_poller, "0.5.1"},
      {:gettext, "0.18.2"},
      {:jason, "1.2.2"},
      {:plug_cowboy, "2.4.1"},
      {:credo, "1.5.5", only: [:dev, :test], runtime: false},
      {:excoveralls, "0.13.4", only: :test},
      {:commanded, "1.2.0"},
      {:eventstore, "1.2.3"},
      {:commanded_eventstore_adapter, "1.2.0"},
      {:commanded_ecto_projections, "1.2.1"},
      {:absinthe, "1.6.3"},
      {:absinthe_plug, "1.5.5"},
      {:crudry, "2.3.1"},
      {:cors_plug, "2.0.3"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": [
        "ecto.create",
        "ecto.migrate",
        "event_store.create",
        "event_store.init",
        "run priv/repo/seeds.exs"
      ],
      "ecto.reset": ["ecto.drop", "event_store.drop", "ecto.setup"],
      test: [
        "ecto.drop --quiet",
        "event_store.drop --quiet",
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "event_store.create --quiet",
        "event_store.init --quiet",
        "test"
      ],
      lint: ["format", "credo"]
    ]
  end
end
