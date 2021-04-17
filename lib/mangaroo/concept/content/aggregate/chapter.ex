defmodule Mangaroo.Concept.Content.Aggregate.Chapter do
  @moduledoc false

  alias __MODULE__
  alias Mangaroo.Concept.Content.Command.CreateChapter
  alias Mangaroo.Concept.Content.Event.ChapterCreated

  defstruct [
    :chapter_uuid,
    :manga_id,
    :name,
    :chapter_archive_content_type,
    :chapter_archive_filename,
    :chapter_archive_path
  ]

  def execute(%Chapter{}, %CreateChapter{} = command) do
    {%Plug.Upload{} = chapter_archive, _} = command.chapter_archive

    %ChapterCreated{
      chapter_uuid: command.chapter_uuid,
      manga_id: command.manga_id,
      name: command.name,
      chapter_archive_content_type: chapter_archive.content_type,
      chapter_archive_filename: chapter_archive.filename,
      chapter_archive_path: chapter_archive.path
    }
  end

  def apply(%Chapter{} = chapter, %ChapterCreated{} = event) do
    %Chapter{
      chapter
      | chapter_uuid: event.chapter_uuid,
        manga_id: event.manga_id,
        name: event.name,
        chapter_archive_content_type: event.chapter_archive_content_type,
        chapter_archive_filename: event.chapter_archive_filename,
        chapter_archive_path: event.chapter_archive_path
    }
  end
end
