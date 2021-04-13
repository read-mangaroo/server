defmodule Mangaroo.Concept.Content.Schema.Chapter do
  @moduledoc false

  use Ecto.Schema

  alias Mangaroo.Concept.Content.Schema.Manga

  schema "chapters" do
    field :uuid, :binary_id
    field :name, :string

    belongs_to :manga, Manga

    timestamps()
  end
end
