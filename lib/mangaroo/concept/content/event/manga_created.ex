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
    :description
  ]
end
