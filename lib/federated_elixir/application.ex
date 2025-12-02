defmodule FederatedElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FederatedElixirWeb.Telemetry,
      FederatedElixir.Repo,
      {DNSCluster, query: Application.get_env(:federated_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FederatedElixir.PubSub},
      # Start a worker by calling: FederatedElixir.Worker.start_link(arg)
      # {FederatedElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      FederatedElixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FederatedElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FederatedElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
