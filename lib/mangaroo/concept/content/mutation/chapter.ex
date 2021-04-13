defmodule Mangaroo.Concept.Content.Mutation.Chapter do
  @moduledoc false

  alias Mangaroo.Commanded
  alias Mangaroo.Concept.Content.Command.CreateChapter
  alias Mangaroo.Concept.Content.Query.Chapter, as: ChapterQuery

  def create(attrs \\ %{}) do
    chapter_uuid = UUID.uuid4()
    attrs = Map.put(attrs, :chapter_uuid, chapter_uuid)
    command = struct(CreateChapter, attrs)

    with :ok <- Commanded.dispatch(command, consistency: :strong) do
      {:ok, ChapterQuery.get_by_uuid(chapter_uuid)}
    end
  end
end
