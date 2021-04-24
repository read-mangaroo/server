defmodule Mangaroo.Concept.Content.EventHandler.MangaCreated do
  @moduledoc """
  Event handler for uploading cover art after a Manga
  record is created.
  """

  use Commanded.Event.Handler,
    application: Mangaroo.Commanded,
    name: __MODULE__

  alias Mangaroo.Concept.Content.Event.MangaCreated
  alias Mangaroo.Worker.Uploader, as: UploadWorker

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
      File.mkdir_p!(Path.expand("tmp/upload_cache"))
      tmp_path = Path.expand("tmp/upload_cache/#{filename}")
      File.cp!(path, Path.expand(tmp_path))

      %{
        env: Application.get_env(:mangaroo, :environment) |> Atom.to_string(),
        type: "cover_art",
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
