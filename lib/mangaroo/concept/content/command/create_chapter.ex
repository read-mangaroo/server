defmodule Mangaroo.Concept.Content.Command.CreateChapter do
  @moduledoc false
  @behaviour Mangaroo.Behaviour.MangarooCommand

  use Ecto.Schema
  use Waffle.Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "abstract table: :create_chapter" do
    field :chapter_uuid, :binary_id
    field :manga_id, :integer
    field :name, :string
    field :chapter_archive, :any, virtual: true
  end

  @required_attrs [
    :chapter_uuid,
    :manga_id,
    :name,
    :chapter_archive
  ]

  @impl Mangaroo.Behaviour.MangarooCommand
  def changeset(%CreateChapter{} = create_chapter, attrs \\ %{}) do
    create_chapter
    |> cast(attrs, @required_attrs)
    |> cast_attachments(attrs, [:chapter_archive])
    |> validate_required(@required_attrs)
  end
end
