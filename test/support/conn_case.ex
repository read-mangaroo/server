defmodule MangarooWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use MangarooWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use Oban.Testing, repo: Mangaroo.Repo

      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import MangarooWeb.ConnCase
      import MangarooWeb.AbsintheHelpers
      import Mangaroo.Factories
      import Commanded.Assertions.EventAssertions

      alias MangarooWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint MangarooWeb.Endpoint
    end
  end

  setup _tags do
    {:ok, _} = Application.ensure_all_started(:mangaroo)

    on_exit(fn ->
      :ok = Application.stop(:mangaroo)

      Mangaroo.EventStoreStorage.reset!()
    end)

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
