defmodule Mangaroo.Concept.Content.Mutation.Manga do
  @moduledoc false

  alias Mangaroo.Commanded
  alias Mangaroo.Concept.Content.Command.CreateManga
  alias Mangaroo.Concept.Content.Query.Manga, as: MangaQuery

  def create(attrs \\ %{}) do
    manga_uuid = UUID.uuid4()
    attrs = Map.put(attrs, :manga_uuid, manga_uuid)
    command = struct(CreateManga, attrs)

    with :ok <- Commanded.dispatch(command, consistency: :strong) do
      {:ok, MangaQuery.get_by_uuid(manga_uuid)}
    end
  end
end
