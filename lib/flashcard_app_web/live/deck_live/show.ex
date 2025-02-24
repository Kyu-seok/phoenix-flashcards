defmodule FlashcardAppWeb.DeckLive.Show do
  use FlashcardAppWeb, :live_view

  alias FlashcardApp.Cards

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    flashcards = Cards.list_flashcards_by_deck(id)

    IO.puts("Howdy")
    IO.inspect(flashcards)

    {:ok,
     socket
     |> assign(:flashcards, flashcards)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:deck, Cards.get_deck!(id))
     |> assign(:flashcards, Cards.list_flashcards_by_deck(id))}
  end

  defp page_title(:show), do: "Show Deck"
  defp page_title(:edit), do: "Edit Deck"

  # TODO: implement the action for new, and edit the flash card
  # defp apply_action(socket, :edit, %{"id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit Deck")
  #   |> assign(:deck, Cards.get_deck!(id))
  # end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New Deck")
  #   |> assign(:deck, %Deck{})
  # end
end
