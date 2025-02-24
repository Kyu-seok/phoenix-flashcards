defmodule FlashcardAppWeb.DeckLive.Show do
  use FlashcardAppWeb, :live_view

  alias FlashcardApp.Cards
  alias FlashcardApp.Cards.Flashcard

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    deck = Cards.get_deck!(id)
    flashcards = Cards.list_flashcards_by_deck(id)

    {:ok,
     socket
     |> assign(:deck, deck)
     |> assign(:flashcards, flashcards)
     |> assign(:flashcard, %Flashcard{})
     |> assign(:flashcard_changeset, Cards.change_flashcard(%Flashcard{}))}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    deck = Cards.get_deck!(id)
    flashcards = Cards.list_flashcards_by_deck(id)

    {:noreply,
     socket
     # TODO : delete below? check if below needed to be deleted
     #  |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:deck, deck)
     |> assign(:flashcards, flashcards)
     |> assign(:flashcard, %Flashcard{deck_id: deck.id})
     |> assign(:flashcard_changeset, Cards.change_flashcard(%Flashcard{}))}
  end

  @impl true
  def handle_event("validate", %{"flashcard" => flashcard_params}, socket) do
    changeset = Cards.change_flashcard(socket.assigns.flashcard, flashcard_params)
    {:noreply, assign(socket, flashcard_changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"flashcard" => flashcard_params}, socket) do
    case Cards.create_flashcard(Map.put(flashcard_params, "deck_id", socket.assigns.deck.id)) do
      {:ok, _flashcard} ->
        {:noreply,
         socket
         |> put_flash(:info, "Flashcard created successfully")
         |> assign(:flashcards, Cards.list_flashcards_by_deck(socket.assigns.deck.id))
         |> assign(:flashcard, %Flashcard{})}

      {:error, changeset} ->
        {:noreply, assign(socket, flashcard_changeset: changeset)}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    flashcard = Cards.get_flashcard!(id)
    {:ok, _} = Cards.delete_flashcard(flashcard)

    {:noreply,
     socket
     |> put_flash(:info, "Flashcard deleted successfully")
     |> assign(:flashcards, Cards.list_flashcards_by_deck(socket.assigns.deck.id))}
  end

  defp page_title(:show), do: "Show Deck"
  defp page_title(:edit), do: "Edit Deck"
end
