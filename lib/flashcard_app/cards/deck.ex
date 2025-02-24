defmodule FlashcardApp.Cards.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "decks" do
    field :title, :string
    # field :user_id, :id
    belongs_to :user, FlashcardApp.Accounts.User
    has_many :flashcards, FlashcardApp.Cards.Flashcard

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
