defmodule FlashcardAppWeb.FlashcardLive.Show do
  use FlashcardAppWeb, :live_view

  alias FlashcardApp.Cards

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:flashcard, Cards.get_flashcard!(id))}
  end

  defp page_title(:show), do: "Show Flashcard"
  defp page_title(:edit), do: "Edit Flashcard"
end
