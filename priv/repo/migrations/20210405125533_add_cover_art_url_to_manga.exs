defmodule Mangaroo.Repo.Migrations.AddCoverArtUrlToManga do
  use Ecto.Migration

  def change do
    alter table(:manga) do
      add :cover_art_url, :string
    end
  end
end
