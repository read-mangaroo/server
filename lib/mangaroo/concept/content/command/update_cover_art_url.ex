defmodule Mangaroo.Concept.Content.Command.UpdateCoverArtUrl do
  @moduledoc false

  @behaviour Mangaroo.Behaviour.MangarooCommand

  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "abstract table: :update_cover_art_url" do
    field :manga_uuid, :binary_id
    field :cover_art_url, :string
  end

  @required_attr [:manga_uuid, :cover_art_url]

  @impl Mangaroo.Behaviour.MangarooCommand
  def changeset(%UpdateCoverArtUrl{} = update_cover_art_url, attrs \\ %{}) do
    update_cover_art_url
    |> cast(attrs, @required_attr)
    |> validate_required(@required_attr)
  end
end
