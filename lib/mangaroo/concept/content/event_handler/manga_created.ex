defmodule Mangaroo.Concept.Content.EventHandler.MangaCreated do
  @moduledoc """
  Event handler for uploading cover art after a Manga
  record is created.
  """

  use Commanded.Event.Handler,
    application: Mangaroo.Commanded,
    name: __MODULE__

  alias Mangaroo.Concept.Content.Event.MangaCreated
  alias Mangaroo.Uploaders.CoverArt, as: CoverArtUploader

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
      do_store_cover_art(
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

  defp do_store_cover_art(:prod, id, content_type, filename, path) do
    # coveralls-ignore-start
    tmp_path = Path.expand("tmp/multipart_cache/#{filename}")
    File.cp!(path, Path.expand(tmp_path))

    cover_art = %Plug.Upload{
      content_type: content_type,
      filename: filename,
      path: tmp_path
    }

    case CoverArtUploader.store({cover_art, %{id: id}}) do
      {:ok, _} ->
        File.rm!(tmp_path)

      {:error, _} ->
        :error
    end

    # coveralls-ignore-stop
  end

  defp do_store_cover_art(_env, id, content_type, filename, path) do
    cover_art = %Plug.Upload{
      content_type: content_type,
      filename: filename,
      path: path
    }

    case CoverArtUploader.store({cover_art, %{id: id}}) do
      {:ok, _} ->
        :ok

      {:error, _} ->
        :error
    end
  end
end
