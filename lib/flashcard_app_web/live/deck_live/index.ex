defmodule FlashcardAppWeb.DeckLive.Index do
  use FlashcardAppWeb, :live_view

  alias FlashcardApp.Cards
  alias FlashcardApp.Cards.Deck

  @impl true
  def mount(_params, session, socket) do
    current_user =
      session["user_token"] &&
        FlashcardApp.Accounts.get_user_by_session_token(session["user_token"])

    # {:ok, stream(socket, :decks, Cards.list_decks())}

    {:ok,
     socket
     |> assign(:current_user, current_user)
     |> stream(:decks, Cards.list_decks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Deck")
    |> assign(:deck, Cards.get_deck!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deck")
    |> assign(:deck, %Deck{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Decks")
    |> assign(:deck, nil)
  end

  @impl true
  def handle_info({FlashcardAppWeb.DeckLive.FormComponent, {:saved, deck}}, socket) do
    {:noreply, stream_insert(socket, :decks, deck)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deck = Cards.get_deck!(id)
    {:ok, _} = Cards.delete_deck(deck)

    {:noreply, stream_delete(socket, :decks, deck)}
  end
end
