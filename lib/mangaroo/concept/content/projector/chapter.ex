defmodule Mangaroo.Concept.Content.Projector.Chapter do
  @moduledoc false

  use Commanded.Projections.Ecto,
    application: Mangaroo.Commanded,
    name: __MODULE__,
    consistency: :strong

  alias Ecto.Multi
  alias Mangaroo.Concept.Content.Event.ChapterCreated
  alias Mangaroo.Concept.Content.Schema.Chapter

  project(%ChapterCreated{} = event, fn multi ->
    Multi.insert(multi, :chapter, %Chapter{
      uuid: event.chapter_uuid,
      name: event.name,
      manga_id: event.manga_id
    })
  end)
end
