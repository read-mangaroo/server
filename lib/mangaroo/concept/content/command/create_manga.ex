defmodule Mangaroo.Concept.Content.Command.CreateManga do
  @moduledoc false
  @behaviour Mangaroo.Behaviour.MangarooCommand

  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "abstract table: :create_manga" do
    field :manga_uuid, :binary_id
    field :name, :string
    field :author, :string
    field :artist, :string
    field :status, :string
    field :demographic, :string
    field :is_hentai, :boolean, default: false
    field :description, :string
    field :cover_art, :any, virtual: true
  end

  @required_attrs [
    :manga_uuid,
    :name,
    :author,
    :artist,
    :status
  ]

  @optional_attrs [
    :demographic,
    :is_hentai,
    :description,
    :cover_art
  ]

  @accepted_status ~w(ongoing completed cancelled hiatus)
  @accepted_demographic ~w(shounen shoujo seinen josei)

  @impl Mangaroo.Behaviour.MangarooCommand
  def changeset(%CreateManga{} = create_manga, attrs \\ %{}) do
    create_manga
    |> cast(attrs, @required_attrs ++ @optional_attrs)
    |> cast_attachments(attrs, [:cover_art])
    |> validate_required(@required_attrs)
    |> validate_inclusion(:status, @accepted_status)
    |> validate_inclusion(:demographic, @accepted_demographic)
  end
end
