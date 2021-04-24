defmodule Mangaroo.Concept.Content.Mutation.MangaTest do
  use Mangaroo.DataCase

  alias Mangaroo.Concept.Content.Mutation.Manga, as: MangaMutation
  alias Mangaroo.Concept.Content.Schema.Manga

  describe "create/1" do
    test "with valid data creates new Manga" do
      attrs = %{
        name: "Test Manga Name",
        author: "Test Manga Author",
        artist: "Test Manga Artist",
        status: "ongoing",
        demographic: "shounen",
        description: "Test Manga Description"
      }

      {:ok, %Manga{} = manga} = MangaMutation.create(attrs)

      assert manga.id
      assert manga.uuid
      assert manga.name == "Test Manga Name"
      assert manga.author == "Test Manga Author"
      assert manga.artist == "Test Manga Artist"
      assert manga.status == "ongoing"
      assert manga.demographic == "shounen"
      assert manga.is_hentai == false
      assert manga.description == "Test Manga Description"
    end

    test "with valid data and cover art creates new Manga" do
      attrs = %{
        name: "Test Manga Name",
        author: "Test Manga Author",
        artist: "Test Manga Artist",
        status: "ongoing",
        demographic: "shounen",
        description: "Test Manga Description",
        cover_art: %Plug.Upload{
          content_type: "image/png",
          path: Path.expand("../../../../fixtures/cover_art_placeholder.png", __DIR__),
          filename: "cover_art_placeholder.png"
        }
      }

      {:ok, %Manga{} = manga} = MangaMutation.create(attrs)

      wait_for_event(Mangaroo.Commanded, Mangaroo.Concept.Content.Event.MangaCreated, fn _ ->
        assert_enqueued(worker: Mangaroo.Worker.Uploader)

        Oban.drain_queue(queue: :media)
        assert manga.id
        assert manga.uuid
        assert manga.name == "Test Manga Name"
      end)
    end

    test "with blank data returns errors" do
      {:error, %Ecto.Changeset{} = changeset} = MangaMutation.create(%{})

      assert Enum.count(changeset.errors) == 4
      assert changeset.errors[:name] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:author] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:artist] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:status] == {"can't be blank", [validation: :required]}
      assert changeset.errors[:demographic] == nil
    end

    test "with invalid status returns error" do
      attrs = %{
        name: "Test Manga Name",
        author: "Test Manga Author",
        artist: "Test Manga Artist",
        status: "invalid",
        demographic: "shounen",
        description: "Test Manga Description"
      }

      {:error, %Ecto.Changeset{} = changeset} = MangaMutation.create(attrs)

      assert Enum.count(changeset.errors) == 1

      assert changeset.errors[:status] ==
               {"is invalid",
                [validation: :inclusion, enum: ["ongoing", "completed", "cancelled", "hiatus"]]}
    end

    test "with invalid demographic returns error" do
      attrs = %{
        name: "Test Manga Name",
        author: "Test Manga Author",
        artist: "Test Manga Artist",
        status: "ongoing",
        demographic: "invalid",
        description: "Test Manga Description"
      }

      {:error, %Ecto.Changeset{} = changeset} = MangaMutation.create(attrs)

      assert Enum.count(changeset.errors) == 1

      assert changeset.errors[:demographic] ==
               {"is invalid",
                [validation: :inclusion, enum: ["shounen", "shoujo", "seinen", "josei"]]}
    end
  end
end
