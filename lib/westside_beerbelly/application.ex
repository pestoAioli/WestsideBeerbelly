defmodule WestsideBeerbelly.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WestsideBeerbellyWeb.Telemetry,
      WestsideBeerbelly.Repo,
      {DNSCluster, query: Application.get_env(:westside_beerbelly, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WestsideBeerbelly.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WestsideBeerbelly.Finch},
      # Start a worker by calling: WestsideBeerbelly.Worker.start_link(arg)
      # {WestsideBeerbelly.Worker, arg},
      # Start to serve requests, typically the last entry
      WestsideBeerbellyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WestsideBeerbelly.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WestsideBeerbellyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
