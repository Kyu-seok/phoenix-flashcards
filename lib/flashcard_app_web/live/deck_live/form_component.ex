defmodule FlashcardAppWeb.DeckLive.FormComponent do
  use FlashcardAppWeb, :live_component

  alias FlashcardApp.Cards

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage deck records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="deck-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Deck</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{deck: deck} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Cards.change_deck(deck))
     end)}
  end

  @impl true
  def handle_event("validate", %{"deck" => deck_params}, socket) do
    changeset = Cards.change_deck(socket.assigns.deck, deck_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"deck" => deck_params}, socket) do
    save_deck(socket, socket.assigns.action, deck_params)
  end

  defp save_deck(socket, :edit, deck_params) do
    case Cards.update_deck(socket.assigns.deck, deck_params) do
      {:ok, deck} ->
        notify_parent({:saved, deck})

        {:noreply,
         socket
         |> put_flash(:info, "Deck updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_deck(socket, :new, deck_params) do
    user_id = socket.assigns.current_user.id

    case Cards.create_deck(Map.put(deck_params, "user_id", user_id)) do
      {:ok, deck} ->
        notify_parent({:saved, deck})

        {:noreply,
         socket
         |> put_flash(:info, "Deck created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
