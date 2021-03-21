defmodule Mangaroo.Concept.Content.Aggregate.Manga do
  @moduledoc false

  defstruct [
    :manga_uuid,
    :name,
    :author,
    :artist,
    :status,
    :demographic,
    :is_hentai,
    :description
  ]

  alias __MODULE__
  alias Mangaroo.Concept.Content.Command.CreateManga
  alias Mangaroo.Concept.Content.Event.MangaCreated

  def execute(%Manga{}, %CreateManga{} = command) do
    %MangaCreated{
      manga_uuid: command.manga_uuid,
      name: command.name,
      author: command.author,
      artist: command.artist,
      status: command.status,
      demographic: command.demographic,
      is_hentai: command.is_hentai,
      description: command.description
    }
  end

  def apply(%Manga{} = manga, %MangaCreated{} = event) do
    %Manga{
      manga
      | manga_uuid: event.manga_uuid,
        name: event.name,
        author: event.author,
        artist: event.artist,
        status: event.status,
        demographic: event.demographic,
        is_hentai: event.is_hentai,
        description: event.description
    }
  end
end
