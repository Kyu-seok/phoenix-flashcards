defmodule FlashcardAppWeb.FlashcardLive.FormComponent do
  use FlashcardAppWeb, :live_component

  alias FlashcardApp.Cards

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage flashcard records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="flashcard-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:front_text]} type="text" label="Front text" />
        <.input field={@form[:back_text]} type="text" label="Back text" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Flashcard</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{flashcard: flashcard} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Cards.change_flashcard(flashcard))
     end)}
  end

  @impl true
  def handle_event("validate", %{"flashcard" => flashcard_params}, socket) do
    changeset = Cards.change_flashcard(socket.assigns.flashcard, flashcard_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"flashcard" => flashcard_params}, socket) do
    save_flashcard(socket, socket.assigns.action, flashcard_params)
  end

  defp save_flashcard(socket, :edit, flashcard_params) do
    case Cards.update_flashcard(socket.assigns.flashcard, flashcard_params) do
      {:ok, flashcard} ->
        notify_parent({:saved, flashcard})

        {:noreply,
         socket
         |> put_flash(:info, "Flashcard updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_flashcard(socket, :new, flashcard_params) do
    case Cards.create_flashcard(flashcard_params) do
      {:ok, flashcard} ->
        notify_parent({:saved, flashcard})

        {:noreply,
         socket
         |> put_flash(:info, "Flashcard created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
