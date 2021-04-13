defmodule Mangaroo.Concept.Content.Router do
  use Commanded.Commands.Router

  alias Mangaroo.Concept.Content.Aggregate.{Chapter, Manga}
  alias Mangaroo.Concept.Content.Command.{CreateChapter, CreateManga, UpdateCoverArtUrl}

  middleware(Mangaroo.Middleware.ValidateCommand)

  identify(Chapter, by: :chapter_uuid, prefix: "chapter-")
  identify(Manga, by: :manga_uuid, prefix: "manga-")

  dispatch([CreateChapter], to: Chapter)
  dispatch([CreateManga, UpdateCoverArtUrl], to: Manga)
end
