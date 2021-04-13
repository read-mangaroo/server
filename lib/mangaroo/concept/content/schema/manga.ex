defmodule Mangaroo.Concept.Content.Schema.Manga do
  @moduledoc false

  use Ecto.Schema

  alias Mangaroo.Concept.Content.Schema.Chapter

  schema "manga" do
    field :uuid, :binary_id
    field :name, :string
    field :author, :string
    field :artist, :string
    field :status, :string
    field :demographic, :string
    field :is_hentai, :boolean, default: false
    field :description, :string
    field :cover_art_url, :string

    has_many :chapters, Chapter

    timestamps()
  end
end
