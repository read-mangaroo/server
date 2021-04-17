defmodule MangarooWeb.Graph.Schema.Content do
  @moduledoc """
  GraphQL objects, queries, and mutations for the Content concept.
  """

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MangarooWeb.Graph.Resolver.Content, as: ContentResolver

  object :chapter do
    field(:id, :id)
    field(:name, :string)
    field(:manga_id, :id)
    field(:inserted_at, :naive_datetime)

    field(:manga, :manga, resolve: dataloader(:mangas))
  end

  object :manga do
    field(:id, :id)
    field(:name, :string)
    field(:author, :string)
    field(:artist, :string)
    field(:status, :string)
    field(:demographic, :string)
    field(:is_hentai, :boolean)
    field(:description, :string)
    field(:cover_art_url, :string)

    field(:chapters, list_of(:chapter), resolve: dataloader(:chapters))
  end

  input_object :create_chapter_input do
    field(:name, non_null(:string))
    field(:manga_id, non_null(:id))
    field(:chapter_archive, :upload)
  end

  input_object :create_manga_input do
    field(:name, non_null(:string))
    field(:author, non_null(:string))
    field(:artist, non_null(:string))
    field(:status, non_null(:string))
    field(:demographic, :string)
    field(:is_hentai, :boolean)
    field(:description, :string)
    field(:cover_art, :upload)
  end

  object :content_queries do
    field(:chapter, :chapter) do
      arg(:id, non_null(:id))
      resolve(&ContentResolver.get_chapter/3)
    end

    field(:mangas, list_of(:manga)) do
      resolve(&ContentResolver.list_manga/3)
    end

    field(:manga, :manga) do
      arg(:id, non_null(:id))
      resolve(&ContentResolver.get_manga/3)
    end
  end

  object :content_mutations do
    field(:create_chapter, :chapter) do
      arg(:input, non_null(:create_chapter_input))
      resolve(&ContentResolver.create_chapter/3)
    end

    field(:create_manga, :manga) do
      arg(:input, non_null(:create_manga_input))
      resolve(&ContentResolver.create_manga/3)
    end
  end
end
