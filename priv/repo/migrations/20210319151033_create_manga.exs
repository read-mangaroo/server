defmodule Mangaroo.Repo.Migrations.CreateMangas do
  use Ecto.Migration

  def change do
    create table(:manga) do
      add :uuid, :binary_id, null: false
      add :name, :string, null: false
      add :author, :string, null: false
      add :artist, :string, null: false
      add :status, :string, null: false
      add :demographic, :string
      add :is_hentai, :boolean, default: false
      add :description, :text

      timestamps()
    end

    create index(:manga, :uuid)
    create index(:manga, :name)
    create index(:manga, :author)
    create index(:manga, :artist)
    create index(:manga, :status)
    create index(:manga, :demographic)
    create index(:manga, :is_hentai)
  end
end
