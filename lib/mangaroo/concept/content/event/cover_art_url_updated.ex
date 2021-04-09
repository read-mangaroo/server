defmodule Mangaroo.Concept.Content.Event.CoverArtUrlUpdated do
  @moduledoc false

  @derive Jason.Encoder

  defstruct [:manga_uuid, :cover_art_url]
end
