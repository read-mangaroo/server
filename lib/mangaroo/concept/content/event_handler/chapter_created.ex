defmodule Mangaroo.Concept.Content.EventHandler.ChapterCreated do
  @moduledoc false

  use Commanded.Event.Handler,
    application: Mangaroo.Commanded,
    name: __MODULE__

  alias Mangaroo.Concept.Content.Event.ChapterCreated
  alias Mangaroo.Uploaders.ChapterArchive, as: ChapterArchiveUploader

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
      do_store_chapter_archive(
        Application.get_env(:mangaroo, :environment),
        id,
        content_type,
        filename,
        path
      )
    else
      :ok
    end
  end

  defp do_store_chapter_archive(:prod, id, content_type, filename, path) do
    # coveralls-ignore-start
    File.mkdir_p!(Path.expand("tmp/multipart_cache"))
    tmp_path = Path.expand("tmp/multipart_cache/#{filename}")
    File.cp!(path, Path.expand(tmp_path))

    cover_art = %Plug.Upload{
      content_type: content_type,
      filename: filename,
      path: tmp_path
    }

    case ChapterArchiveUploader.store({cover_art, %{id: id}}) do
      {:ok, _} -> File.rm!(tmp_path)
      {:error, _} -> :error
    end

    # coveralls-ignore-stop
  end

  defp do_store_chapter_archive(_env, id, content_type, filename, path) do
    chapter_archive = %Plug.Upload{
      content_type: content_type,
      filename: filename,
      path: path
    }

    case ChapterArchiveUploader.store({chapter_archive, %{id: id}}) do
      {:ok, _} -> :ok
      {:error, _} -> :error
    end
  end
end
