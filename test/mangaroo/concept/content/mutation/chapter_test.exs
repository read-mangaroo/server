defmodule Mangaroo.Concept.Content.Mutation.ChapterTest do
  use Mangaroo.DataCase

  alias Mangaroo.Concept.Content.Mutation.Chapter, as: ChapterMutation
  alias Mangaroo.Concept.Content.Schema.Chapter

  describe "create/1" do
    test "with valid data creates new Chapter" do
      manga = manga_fixture()

      attrs = %{
        name: "Test Chapter Name",
        manga_id: manga.id
      }

      {:ok, %Chapter{} = chapter} = ChapterMutation.create(attrs)

      assert chapter.id
      assert chapter.uuid
      assert chapter.name == "Test Chapter Name"
      assert chapter.manga_id == manga.id
    end

    test "with blank data returns errors" do
      {:error, %Ecto.Changeset{} = changeset} = ChapterMutation.create(%{})

      assert Enum.count(changeset.errors) == 2
      assert changeset.errors[:manga_id] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:name] == {"can't be blank", [validation: :required]}
    end
  end
end
