defmodule Mangaroo.Concept.Content.Mutation.ChapterTest do
  use Mangaroo.DataCase

  alias Mangaroo.Concept.Content.Mutation.Chapter, as: ChapterMutation
  alias Mangaroo.Concept.Content.Schema.Chapter

  describe "create/1" do
    test "with valid data creates new Chapter" do
      manga = manga_fixture()

      attrs = %{
        name: "Test Chapter Name",
        manga_id: manga.id,
        chapter_archive: %Plug.Upload{
          content_type: "application/zip",
          path: Path.expand("../../../../fixtures/test\ chapter.zip", __DIR__),
          filename: "test\ chapter.zip"
        }
      }

      {:ok, %Chapter{} = chapter} = ChapterMutation.create(attrs)

      assert Oban.drain_queue(queue: :media) == %{success: 1, failure: 0}
      assert chapter.id
      assert chapter.uuid
      assert chapter.name == "Test Chapter Name"
      assert chapter.manga_id == manga.id
      assert chapter.status == "pending"
    end

    test "with blank data returns errors" do
      {:error, %Ecto.Changeset{} = changeset} = ChapterMutation.create(%{})

      assert Enum.count(changeset.errors) == 3
      assert changeset.errors[:manga_id] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:name] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:chapter_archive] == {"can't be blank", [validation: :required]}
    end
  end
end
