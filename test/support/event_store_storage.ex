defmodule Mangaroo.EventStoreStorage do
  @doc """
  Reset the event store and read store databases.
  """
  def reset! do
    :ok = Application.stop(:mangaroo)

    reset_eventstore!()
    reset_readstore!()

    {:ok, _} = Application.ensure_all_started(:mangaroo)
  end

  defp reset_eventstore! do
    config = Mangaroo.EventStore.config()

    {:ok, conn} =
      config
      |> EventStore.Config.default_postgrex_opts()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn, config)
  end

  defp reset_readstore! do
    {:ok, conn} = Postgrex.start_link(Mangaroo.Repo.config())

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      chapters,
      manga,
      projection_versions
    RESTART IDENTITY;
    """
  end
end
