defmodule Mangaroo.Concept.Content.Query.Chapter do
  @moduledoc false

  import Ecto.Query

  alias Mangaroo.Concept.Content.Schema.Chapter
  alias Mangaroo.Repo

  def list(manga_id) do
    Chapter
    |> where([c], c.manga_id == ^manga_id)
    |> order_by([c], desc: c.inserted_at)
    |> Repo.all()
  end

  def get(id) do
    Repo.get(Chapter, id)
  end

  def get_by_uuid(uuid) do
    Repo.get_by(Chapter, %{uuid: uuid})
  end

  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Chapter, _params) do
    from(c in Chapter, order_by: [desc: c.inserted_at])
  end

  def query(queryable, _params), do: queryable
end
