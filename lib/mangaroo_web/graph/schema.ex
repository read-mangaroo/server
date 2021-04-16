defmodule MangarooWeb.Graph.Schema do
  @moduledoc """
  GraphQL schema for Mangaroo
  """

  use Absinthe.Schema

  alias Crudry.Middlewares.TranslateErrors
  alias Mangaroo.Concept.Content.Query.Chapter, as: ChapterQuery
  alias Mangaroo.Concept.Content.Query.Manga, as: MangaQuery

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

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:chapters, ChapterQuery.data())
      |> Dataloader.add_source(:mangas, MangaQuery.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
