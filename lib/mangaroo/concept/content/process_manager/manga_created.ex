defmodule Mangaroo.Concept.Content.ProcessManager.MangaCreated do
  @moduledoc false

  use Commanded.ProcessManagers.ProcessManager,
    application: Mangaroo.Commanded,
    name: __MODULE__

  @derive Jason.Encoder
  defstruct [:manga_uuid]

  alias __MODULE__, as: MangaCreatedProcessManager
  alias Mangaroo.Concept.Content.Command.UpdateCoverArtUrl
  alias Mangaroo.Concept.Content.Event.{CoverArtUrlUpdated, MangaCreated}
  alias Mangaroo.Uploaders.CoverArt, as: CoverArtUploader

  def interested?(%MangaCreated{
        manga_uuid: manga_uuid,
        cover_art_content_type: _,
        cover_art_filename: _,
        cover_art_path: _
      }) do
    {:start!, manga_uuid}
  end

  def interested?(%CoverArtUrlUpdated{manga_uuid: manga_uuid}) do
    {:stop, manga_uuid}
  end

  def interested(_event), do: false

  def handle(%MangaCreatedProcessManager{}, %MangaCreated{} = event) do
    cover_art_url = CoverArtUploader.url({event.cover_art_filename, %{id: event.manga_uuid}})

    # coveralls-ignore-start
    cover_art_url =
      if Mix.env() == :prod do
        cover_art_url
      else
        "http://localhost:4000/uploads#{cover_art_url}"
      end

    # coveralls-ignore-stop

    %UpdateCoverArtUrl{manga_uuid: event.manga_uuid, cover_art_url: cover_art_url}
  end
end
