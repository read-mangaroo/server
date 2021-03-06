defmodule Mangaroo.Concept.Content.Query.Manga do
  @moduledoc false

  alias Mangaroo.Concept.Content.Schema.Manga
  alias Mangaroo.Repo

  def list do
    Repo.all(Manga)
  end

  def get(id) do
    Repo.get(Manga, id)
  end

  def get_by_uuid(uuid) do
    Repo.get_by(Manga, %{uuid: uuid})
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _params), do: queryable
end
