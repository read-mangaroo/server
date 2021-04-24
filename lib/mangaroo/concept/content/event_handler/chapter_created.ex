defmodule Mangaroo.Concept.Content.EventHandler.ChapterCreated do
  @moduledoc false

  use Commanded.Event.Handler,
    application: Mangaroo.Commanded,
    name: __MODULE__

  alias Mangaroo.Concept.Content.Event.ChapterCreated
  alias Mangaroo.Worker.Uploader, as: UploadWorker

  def handle(
        %ChapterCreated{
          chapter_uuid: id,
          chapter_archive_content_type: content_type,
          chapter_archive_filename: filename,
          chapter_archive_path: path
        },
        _metadata
      ) do
    if content_type && filename && path do
      File.mkdir_p!(Path.expand("tmp/upload_cache"))
      tmp_path = Path.expand("tmp/upload_cache/#{filename}")
      File.cp!(path, Path.expand(tmp_path))

      %{
        type: "chapter_archive",
        id: id,
        content_type: content_type,
        filename: filename,
        path: tmp_path
      }
      |> UploadWorker.new()
      |> Oban.insert()
    else
      :ok
    end
  end
end
