defmodule Mangaroo.Concept.Content.Query.ChapterTest do
  use Mangaroo.DataCase

  alias Mangaroo.Concept.Content.Query.Chapter, as: ChapterQuery

  describe "list/1" do
    test "returns all Chapter records of the given Manga" do
      manga = manga_fixture()

      Enum.each(0..4, fn _ ->
        chapter_fixture(manga)
      end)

      result = ChapterQuery.list(manga.id)
      chapter = Enum.at(result, 0)

      assert Enum.count(result) == 5
      assert chapter.id
      assert chapter.uuid
      assert chapter.name == "Factory Chapter Name"
    end
  end

  describe "get/1" do
    test "with existing id returns the Chapter record" do
      manga = manga_fixture()
      existing_chapter = chapter_fixture(manga)

      chapter = ChapterQuery.get(existing_chapter.id)

      assert chapter.id
      assert chapter.uuid
      assert chapter.name == "Factory Chapter Name"
    end

    test "with non-existing id returns nil" do
      assert ChapterQuery.get(1234) == nil
    end
  end
end
