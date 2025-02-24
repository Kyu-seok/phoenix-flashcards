defmodule FlashcardApp.Repo do
  use Ecto.Repo,
    otp_app: :flashcard_app,
    adapter: Ecto.Adapters.Postgres
end
