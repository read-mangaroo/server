defmodule Mangaroo.Concept.Content.EventHandler.MangaCreated do
  @moduledoc """
  Event handler for uploading cover art after a Manga
  record is created.
  """

  use Commanded.Event.Handler,
    application: Mangaroo.Commanded,
    name: __MODULE__

  alias Mangaroo.Concept.Content.Event.MangaCreated
  alias Mangaroo.Uploaders.CoverArt, as: CoverArtUploader

  def handle(
        %MangaCreated{
          manga_uuid: id,
          cover_art_content_type: content_type,
          cover_art_filename: filename,
          cover_art_path: path
        },
        _metadata
      ) do
    if content_type && filename && path do
      cover_art = %Plug.Upload{
        content_type: content_type,
        filename: filename,
        path: path
      }

      {status, _filename} = CoverArtUploader.store({cover_art, %{id: id}})

      status
    else
      :ok
    end
  end
end
