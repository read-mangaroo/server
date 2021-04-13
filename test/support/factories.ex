defmodule Mangaroo.Factories do
  alias Mangaroo.Concept.Content.Mutation.Chapter, as: ChapterMutation
  alias Mangaroo.Concept.Content.Mutation.Manga, as: MangaMutation
  alias Mangaroo.Concept.Content.Schema.Manga

  def chapter_fixture(%Manga{} = manga, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        manga_id: manga.id,
        name: "Factory Chapter Name"
      })

    {:ok, chapter} = ChapterMutation.create(attrs)

    chapter
  end

  def manga_fixture(attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        name: "Factory Manga Name",
        author: "Factory Manga Author",
        artist: "Factory Manga Artist",
        status: "ongoing",
        demographic: "shounen",
        description: "Factory Manga Description"
      })

    {:ok, manga} = MangaMutation.create(attrs)

    manga
  end
end
