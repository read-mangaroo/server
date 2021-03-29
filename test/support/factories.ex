defmodule Mangaroo.Factories do
  alias Mangaroo.Concept.Content.Mutation.Manga, as: MangaMutation

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
