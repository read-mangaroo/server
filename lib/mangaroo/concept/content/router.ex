defmodule Mangaroo.Concept.Content.Router do
  use Commanded.Commands.Router

  alias Mangaroo.Concept.Content.Aggregate.Manga
  alias Mangaroo.Concept.Content.Command.CreateManga

  middleware(Mangaroo.Middleware.ValidateCommand)

  identify(Manga, by: :manga_uuid, prefix: "manga-")

  dispatch([CreateManga], to: Manga)
end
