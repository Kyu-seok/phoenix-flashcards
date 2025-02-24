defmodule FlashcardApp.Cards do
  @moduledoc """
  The Cards context.
  """

  import Ecto.Query, warn: false
  alias FlashcardApp.Repo

  alias FlashcardApp.Cards.Deck

  @doc """
  Returns the list of decks.

  ## Examples

      iex> list_decks()
      [%Deck{}, ...]

  """
  def list_decks do
    Repo.all(Deck)
  end

  def list_decks_with_user_id(user_id) do
    # TODO: add feature to search using user_id
    Repo.all(Deck)
  end

  @doc """
  Gets a single deck.

  Raises `Ecto.NoResultsError` if the Deck does not exist.

  ## Examples

      iex> get_deck!(123)
      %Deck{}

      iex> get_deck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deck!(id), do: Repo.get!(Deck, id)

  @doc """
  Creates a deck.

  ## Examples

      iex> create_deck(%{field: value})
      {:ok, %Deck{}}

      iex> create_deck(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deck(attrs \\ %{}) do
    %Deck{}
    |> Deck.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deck.

  ## Examples

      iex> update_deck(deck, %{field: new_value})
      {:ok, %Deck{}}

      iex> update_deck(deck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deck(%Deck{} = deck, attrs) do
    deck
    |> Deck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deck.

  ## Examples

      iex> delete_deck(deck)
      {:ok, %Deck{}}

      iex> delete_deck(deck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deck(%Deck{} = deck) do
    Repo.delete(deck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deck changes.

  ## Examples

      iex> change_deck(deck)
      %Ecto.Changeset{data: %Deck{}}

  """
  def change_deck(%Deck{} = deck, attrs \\ %{}) do
    Deck.changeset(deck, attrs)
  end

  alias FlashcardApp.Cards.Flashcard

  @doc """
  Returns the list of flashcards.

  ## Examples

      iex> list_flashcards()
      [%Flashcard{}, ...]

  """
  def list_flashcards do
    Repo.all(Flashcard)
  end

  @doc """
  Gets a single flashcard.

  Raises `Ecto.NoResultsError` if the Flashcard does not exist.

  ## Examples

      iex> get_flashcard!(123)
      %Flashcard{}

      iex> get_flashcard!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flashcard!(id), do: Repo.get!(Flashcard, id)

  def list_flashcards_by_deck(deck_id) do
    Flashcard
    |> where([f], f.deck_id == ^deck_id)
    |> Repo.all()
  end

  @doc """
  Creates a flashcard.

  ## Examples

      iex> create_flashcard(%{field: value})
      {:ok, %Flashcard{}}

      iex> create_flashcard(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flashcard(attrs \\ %{}) do
    %Flashcard{}
    |> Flashcard.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flashcard.

  ## Examples

      iex> update_flashcard(flashcard, %{field: new_value})
      {:ok, %Flashcard{}}

      iex> update_flashcard(flashcard, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flashcard(%Flashcard{} = flashcard, attrs) do
    flashcard
    |> Flashcard.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a flashcard.

  ## Examples

      iex> delete_flashcard(flashcard)
      {:ok, %Flashcard{}}

      iex> delete_flashcard(flashcard)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flashcard(%Flashcard{} = flashcard) do
    Repo.delete(flashcard)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flashcard changes.

  ## Examples

      iex> change_flashcard(flashcard)
      %Ecto.Changeset{data: %Flashcard{}}

  """
  def change_flashcard(%Flashcard{} = flashcard, attrs \\ %{}) do
    Flashcard.changeset(flashcard, attrs)
  end
end
