defmodule MangarooWeb.Graph.Schema do
  @moduledoc """
  GraphQL schema for Mangaroo
  """

  use Absinthe.Schema

  alias Crudry.Middlewares.TranslateErrors

  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)

  import_types(MangarooWeb.Graph.Schema.Content)

  query do
    import_fields(:content_queries)
  end

  mutation do
    import_fields(:content_mutations)
  end

  def middleware(middleware, _field, %Absinthe.Type.Object{identifier: :mutation}) do
    middleware ++ [TranslateErrors]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end
end
