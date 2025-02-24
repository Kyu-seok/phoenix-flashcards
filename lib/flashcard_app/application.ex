defmodule FlashcardApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FlashcardAppWeb.Telemetry,
      FlashcardApp.Repo,
      {DNSCluster, query: Application.get_env(:flashcard_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FlashcardApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FlashcardApp.Finch},
      # Start a worker by calling: FlashcardApp.Worker.start_link(arg)
      # {FlashcardApp.Worker, arg},
      # Start to serve requests, typically the last entry
      FlashcardAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FlashcardApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FlashcardAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
