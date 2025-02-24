defmodule FlashcardAppWeb.FlashcardLive.Form do
  use FlashcardAppWeb, :live_view

  alias FlashcardApp.Cards
  alias FlashcardApp.Cards.Flashcard

  def mount(_params, _session, socket) do
    {:ok, assign(socket, changeset: Cards.change_flashcard(%Flashcard{}))}
  end

  def handle_event("save", %{"flashcard" => flashcard_params}, socket) do
    case Cards.create_flashcard(flashcard_params) do
      {:ok, _flashcard} ->
        {:noreply, redirect(socket, to: "/decks/#{flashcard_params["deck_id"]}")}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
