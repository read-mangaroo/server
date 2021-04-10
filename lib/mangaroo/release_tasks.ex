defmodule Mangaroo.ReleaseTasks do
  @moduledoc false
  @app :mangaroo

  def migrate do
    load_app()

    # migrate database
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end

    # migrate event store
    config = Mangaroo.EventStore.config()
    :ok = EventStore.Tasks.Init.exec(config, [])
    :ok = EventStore.Tasks.Migrate.exec(config, [])
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def seed do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Mangaroo.ReleaseTasks.run_seed_for(&1))
    end
  end

  def run_seed_for(repo) do
    seed_script = priv_path_for(repo, "seeds.exs")

    if File.exists?(seed_script) do
      IO.puts("Running seed script...")
      Code.eval_file(seed_script)
    end
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    {:ok, _} = Application.ensure_all_started(:postgrex)
    {:ok, _} = Application.ensure_all_started(:ssl)

    :ok = Application.load(@app)
  end

  defp priv_path_for(repo, filename) do
    app = Keyword.get(repo.config, :otp_app)

    repo_underscore =
      repo
      |> Module.split()
      |> List.last()
      |> Macro.underscore()

    priv_dir = "#{:code.priv_dir(app)}"

    Path.join([priv_dir, repo_underscore, filename])
  end
end
