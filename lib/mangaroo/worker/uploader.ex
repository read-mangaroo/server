defmodule Mangaroo.Worker.Uploader do
  @moduledoc """
  Worker module for handling Cover Art and Chapter Archive uploads.
  """

  use Oban.Worker, queue: :media

  alias Mangaroo.Concept.Content.Mutation.Manga, as: MangaMutation
  alias Mangaroo.Uploaders.ChapterArchive, as: ChapterArchiveUploader
  alias Mangaroo.Uploaders.CoverArt, as: CoverArtUploader
  alias Oban.Job

  @impl Oban.Worker
  def perform(%Job{
        args: %{
          "type" => "chapter_archive",
          "id" => id,
          "content_type" => content_type,
          "filename" => filename,
          "path" => path
        }
      }) do
    chapter_archive = %Plug.Upload{
      content_type: content_type,
      filename: filename,
      path: path
    }

    with {:ok, _} <- ChapterArchiveUploader.store({chapter_archive, %{id: id}}) do
      File.rm!(path)
    end
  end

  @impl Oban.Worker
  def perform(%Job{
        args: %{
          "env" => env,
          "type" => "cover_art",
          "id" => id,
          "content_type" => content_type,
          "filename" => filename,
          "path" => path
        }
      }) do
    cover_art = %Plug.Upload{
      content_type: content_type,
      filename: filename,
      path: path
    }

    with {:ok, _} <- CoverArtUploader.store({cover_art, %{id: id}}) do
      File.rm!(path)
      cover_art_url = CoverArtUploader.url({filename, %{id: id}})

      # coveralls-ignore-start
      cover_art_url =
        if env == "prod" do
          cover_art_url
        else
          "http://localhost:4000/uploads#{cover_art_url}"
        end

      # coveralls-ignore-stop

      MangaMutation.update_cover_art_url(%{manga_uuid: id, cover_art_url: cover_art_url})
    end
  end
end
