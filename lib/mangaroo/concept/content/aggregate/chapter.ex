defmodule Mangaroo.Concept.Content.Aggregate.Chapter do
  @moduledoc false

  alias __MODULE__
  alias Mangaroo.Concept.Content.Command.CreateChapter
  alias Mangaroo.Concept.Content.Event.ChapterCreated

  defstruct [
    :chapter_uuid,
    :manga_id,
    :name
  ]

  def execute(%Chapter{}, %CreateChapter{} = command) do
    %ChapterCreated{
      chapter_uuid: command.chapter_uuid,
      manga_id: command.manga_id,
      name: command.name
    }
  end

  def apply(%Chapter{} = chapter, %ChapterCreated{} = event) do
    %Chapter{
      chapter
      | chapter_uuid: event.chapter_uuid,
        manga_id: event.manga_id,
        name: event.name
    }
  end
end
