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
    :description,
    :cover_art_content_type,
    :cover_art_filename,
    :cover_art_path,
    :cover_art_url
  ]

  alias __MODULE__
  alias Mangaroo.Concept.Content.Command.{CreateManga, UpdateCoverArtUrl}
  alias Mangaroo.Concept.Content.Event.{CoverArtUrlUpdated, MangaCreated}

  def execute(%Manga{}, %CreateManga{} = command) do
    case command.cover_art do
      {%Plug.Upload{} = cover_art, _} ->
        %MangaCreated{
          manga_uuid: command.manga_uuid,
          name: command.name,
          author: command.author,
          artist: command.artist,
          status: command.status,
          demographic: command.demographic,
          is_hentai: command.is_hentai,
          description: command.description,
          cover_art_content_type: cover_art.content_type,
          cover_art_filename: cover_art.filename,
          cover_art_path: cover_art.path
        }

      _ ->
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
  end

  def execute(%Manga{}, %UpdateCoverArtUrl{} = command) do
    %CoverArtUrlUpdated{
      manga_uuid: command.manga_uuid,
      cover_art_url: command.cover_art_url
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
        description: event.description,
        cover_art_content_type: event.cover_art_content_type,
        cover_art_filename: event.cover_art_filename,
        cover_art_path: event.cover_art_path
    }
  end

  def apply(%Manga{} = manga, %CoverArtUrlUpdated{} = event) do
    %Manga{
      manga
      | manga_uuid: event.manga_uuid,
        cover_art_url: event.cover_art_url
    }
  end
end
