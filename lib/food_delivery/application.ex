defmodule FoodDelivery.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FoodDeliveryWeb.Telemetry,
      FoodDelivery.Repo,
      {DNSCluster, query: Application.get_env(:food_delivery, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FoodDelivery.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FoodDelivery.Finch},
      # Start a worker by calling: FoodDelivery.Worker.start_link(arg)
      # {FoodDelivery.Worker, arg},
      # Start to serve requests, typically the last entry
      FoodDeliveryWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoodDelivery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodDeliveryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
