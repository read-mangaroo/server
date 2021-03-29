defmodule MangarooWeb.Graph.Resolver.Content do
  @moduledoc """
  GraphQL resolver for Content concept schema.
  """

  alias Mangaroo.Concept.Content.Mutation.Manga, as: MangaMutation
  alias Mangaroo.Concept.Content.Query.Manga, as: MangaQuery

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
