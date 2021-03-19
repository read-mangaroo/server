defmodule Mangaroo.MixProject do
  use Mix.Project

  def project do
    [
      app: :mangaroo,
      version: "0.0.0",
      elixir: "1.11.4",
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
      {:commanded_ecto_projections, "1.2.1"}
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
