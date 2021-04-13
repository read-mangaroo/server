defmodule Mangaroo.Repo.Migrations.CreateChapters do
  use Ecto.Migration

  def change do
    create table(:chapters) do
      add :uuid, :binary_id, null: false
      add :name, :string, null: false
      add :status, :string, default: "pending"

      add :manga_id, references(:manga)

      timestamps()
    end

    create index(:chapters, :uuid)
    create index(:chapters, :manga_id)
    create index(:chapters, :status)
  end
end
