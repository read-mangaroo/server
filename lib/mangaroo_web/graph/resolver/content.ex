defmodule MangarooWeb.Graph.Resolver.Content do
  @moduledoc """
  GraphQL resolver for Content concept schema.
  """

  alias Mangaroo.Concept.Content.Mutation.Chapter, as: ChapterMutation
  alias Mangaroo.Concept.Content.Mutation.Manga, as: MangaMutation
  alias Mangaroo.Concept.Content.Query.Chapter, as: ChapterQuery
  alias Mangaroo.Concept.Content.Query.Manga, as: MangaQuery

  def get_chapter(_parent, %{id: id}, _resolution) do
    {:ok, ChapterQuery.get(id)}
  end

  def create_chapter(_parent, %{input: input}, _resolution) do
    ChapterMutation.create(input)
  end

  def list_manga(_parent, _args, _resolution) do
    {:ok, MangaQuery.list()}
  end

  def get_manga(_parent, %{id: id}, _resolution) do
    {:ok, MangaQuery.get(id)}
  end

  def create_manga(_parent, %{input: input}, _resolution) do
    MangaMutation.create(input)
  end
end
