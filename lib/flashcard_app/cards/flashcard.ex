defmodule FlashcardApp.Cards.Flashcard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "flashcards" do
    field :front_text, :string
    field :back_text, :string
    belongs_to :deck, FlashcardApp.Cards.Deck

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(flashcard, attrs) do
    flashcard
    |> cast(attrs, [:front_text, :back_text, :deck_id])
    |> validate_required([:front_text, :back_text, :deck_id])
  end
end
