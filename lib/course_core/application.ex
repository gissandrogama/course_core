defmodule CourseCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CourseCoreWeb.Telemetry,
      CourseCore.Repo,
      {DNSCluster, query: Application.get_env(:course_core, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CourseCore.PubSub},
      # Start a worker by calling: CourseCore.Worker.start_link(arg)
      # {CourseCore.Worker, arg},
      # Start to serve requests, typically the last entry
      CourseCoreWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CourseCore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CourseCoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
