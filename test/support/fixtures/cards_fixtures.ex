defmodule FlashcardApp.CardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FlashcardApp.Cards` context.
  """

  @doc """
  Generate a deck.
  """
  def deck_fixture(attrs \\ %{}) do
    {:ok, deck} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> FlashcardApp.Cards.create_deck()

    deck
  end

  @doc """
  Generate a flashcard.
  """
  def flashcard_fixture(attrs \\ %{}) do
    {:ok, flashcard} =
      attrs
      |> Enum.into(%{
        back_text: "some back_text",
        front_text: "some front_text"
      })
      |> FlashcardApp.Cards.create_flashcard()

    flashcard
  end
end
