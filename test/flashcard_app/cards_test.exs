defmodule FlashcardApp.CardsTest do
  use FlashcardApp.DataCase

  alias FlashcardApp.Cards

  describe "decks" do
    alias FlashcardApp.Cards.Deck

    import FlashcardApp.CardsFixtures

    @invalid_attrs %{title: nil}

    test "list_decks/0 returns all decks" do
      deck = deck_fixture()
      assert Cards.list_decks() == [deck]
    end

    test "get_deck!/1 returns the deck with given id" do
      deck = deck_fixture()
      assert Cards.get_deck!(deck.id) == deck
    end

    test "create_deck/1 with valid data creates a deck" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Deck{} = deck} = Cards.create_deck(valid_attrs)
      assert deck.title == "some title"
    end

    test "create_deck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_deck(@invalid_attrs)
    end

    test "update_deck/2 with valid data updates the deck" do
      deck = deck_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Deck{} = deck} = Cards.update_deck(deck, update_attrs)
      assert deck.title == "some updated title"
    end

    test "update_deck/2 with invalid data returns error changeset" do
      deck = deck_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_deck(deck, @invalid_attrs)
      assert deck == Cards.get_deck!(deck.id)
    end

    test "delete_deck/1 deletes the deck" do
      deck = deck_fixture()
      assert {:ok, %Deck{}} = Cards.delete_deck(deck)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_deck!(deck.id) end
    end

    test "change_deck/1 returns a deck changeset" do
      deck = deck_fixture()
      assert %Ecto.Changeset{} = Cards.change_deck(deck)
    end
  end

  describe "flashcards" do
    alias FlashcardApp.Cards.Flashcard

    import FlashcardApp.CardsFixtures

    @invalid_attrs %{front_text: nil, back_text: nil}

    test "list_flashcards/0 returns all flashcards" do
      flashcard = flashcard_fixture()
      assert Cards.list_flashcards() == [flashcard]
    end

    test "get_flashcard!/1 returns the flashcard with given id" do
      flashcard = flashcard_fixture()
      assert Cards.get_flashcard!(flashcard.id) == flashcard
    end

    test "create_flashcard/1 with valid data creates a flashcard" do
      valid_attrs = %{front_text: "some front_text", back_text: "some back_text"}

      assert {:ok, %Flashcard{} = flashcard} = Cards.create_flashcard(valid_attrs)
      assert flashcard.front_text == "some front_text"
      assert flashcard.back_text == "some back_text"
    end

    test "create_flashcard/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_flashcard(@invalid_attrs)
    end

    test "update_flashcard/2 with valid data updates the flashcard" do
      flashcard = flashcard_fixture()
      update_attrs = %{front_text: "some updated front_text", back_text: "some updated back_text"}

      assert {:ok, %Flashcard{} = flashcard} = Cards.update_flashcard(flashcard, update_attrs)
      assert flashcard.front_text == "some updated front_text"
      assert flashcard.back_text == "some updated back_text"
    end

    test "update_flashcard/2 with invalid data returns error changeset" do
      flashcard = flashcard_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_flashcard(flashcard, @invalid_attrs)
      assert flashcard == Cards.get_flashcard!(flashcard.id)
    end

    test "delete_flashcard/1 deletes the flashcard" do
      flashcard = flashcard_fixture()
      assert {:ok, %Flashcard{}} = Cards.delete_flashcard(flashcard)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_flashcard!(flashcard.id) end
    end

    test "change_flashcard/1 returns a flashcard changeset" do
      flashcard = flashcard_fixture()
      assert %Ecto.Changeset{} = Cards.change_flashcard(flashcard)
    end
  end
end
