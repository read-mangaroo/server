defmodule Mangaroo.Concept.Content.Query.Manga do
  @moduledoc false

  alias Mangaroo.Concept.Content.Schema.Manga
  alias Mangaroo.Repo

  def get_by_uuid(uuid) do
    Repo.get_by(Manga, %{uuid: uuid})
  end
end
