defmodule Mangaroo.Concept.Content.Projector.Manga do
  @moduledoc false

  use Commanded.Projections.Ecto,
    application: Mangaroo.Commanded,
    name: __MODULE__,
    consistency: :strong

  alias Ecto.Multi
  alias Mangaroo.Concept.Content.Event.MangaCreated
  alias Mangaroo.Concept.Content.Schema.Manga

  project(%MangaCreated{} = event, fn multi ->
    Multi.insert(multi, :manga, %Manga{
      uuid: event.manga_uuid,
      name: event.name,
      author: event.author,
      artist: event.artist,
      status: event.status,
      demographic: event.demographic,
      is_hentai: event.is_hentai,
      description: event.description
    })
  end)
end
