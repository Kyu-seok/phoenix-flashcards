defmodule FlashcardApp.Repo.Migrations.CreateFlashcards do
  use Ecto.Migration

  def change do
    create table(:flashcards) do
      add :front_text, :string
      add :back_text, :string
      add :deck_id, references(:decks, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:flashcards, [:deck_id])
  end
end
