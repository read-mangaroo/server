defmodule Mangaroo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Mangaroo.Commanded,
      Mangaroo.Concept.Content.Supervisor,
      Mangaroo.Repo,
      MangarooWeb.Telemetry,
      MangarooWeb.Endpoint,
      {Oban, oban_config()},
      {Phoenix.PubSub, name: Mangaroo.PubSub}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mangaroo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MangarooWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def oban_config do
    Application.fetch_env!(:mangaroo, Oban)
  end
end
