defmodule Mangaroo.Concept.Content.Event.ChapterCreated do
  @moduledoc false
  @derive Jason.Encoder

  defstruct [
    :chapter_uuid,
    :manga_id,
    :name
  ]
end
