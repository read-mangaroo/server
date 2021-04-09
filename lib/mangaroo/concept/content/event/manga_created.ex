defmodule Mangaroo.Concept.Content.Event.MangaCreated do
  @moduledoc false
  @derive Jason.Encoder

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
    :cover_art_path
  ]
end
