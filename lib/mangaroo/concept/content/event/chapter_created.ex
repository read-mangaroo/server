defmodule Mangaroo.Concept.Content.Event.ChapterCreated do
  @moduledoc false
  @derive Jason.Encoder

  defstruct [
    :chapter_uuid,
    :manga_id,
    :name,
    :chapter_archive_content_type,
    :chapter_archive_filename,
    :chapter_archive_path
  ]
end
