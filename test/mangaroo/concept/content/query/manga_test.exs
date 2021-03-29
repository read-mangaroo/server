defmodule Mangaroo.Concept.Content.Query.MangaTest do
  use Mangaroo.DataCase

  alias Mangaroo.Concept.Content.Query.Manga, as: MangaQuery

  describe "list/0" do
    test "returns all Manga records" do
      Enum.each(0..4, fn _ ->
        manga_fixture()
      end)

      result = MangaQuery.list()
      manga = Enum.at(result, 0)

      assert Enum.count(result) == 5
      assert manga.id
      assert manga.uuid
      assert manga.name == "Factory Manga Name"
      assert manga.author == "Factory Manga Author"
      assert manga.artist == "Factory Manga Artist"
      assert manga.status == "ongoing"
      assert manga.demographic == "shounen"
      assert manga.is_hentai == false
      assert manga.description == "Factory Manga Description"
    end
  end

  describe "get/1" do
    test "with existing id returns Manga" do
      fixture = manga_fixture()

      manga = MangaQuery.get(fixture.id)

      assert manga.id == fixture.id
      assert manga.uuid == fixture.uuid
      assert manga.name == fixture.name
      assert manga.author == fixture.author
      assert manga.artist == fixture.artist
      assert manga.status == fixture.status
      assert manga.demographic == fixture.demographic
      assert manga.is_hentai == fixture.is_hentai
      assert manga.description == fixture.description
    end

    test "with non-existing id returns nil" do
      assert MangaQuery.get(123_456) == nil
    end
  end
end
