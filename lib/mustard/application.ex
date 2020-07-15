defmodule Mustard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    :ok = :riak_core.register([{:vnode_module, Mustard.Vnode}])
    :ok = :riak_core_node_watcher.service_up(Mustard.Service, self)

    children = [
      %{
        id: Mustard.VnodeMasterWorker,
        start: {:riak_core_vnode_master, :start_link, [Mustard.Vnode]}
      }
      # Starts a worker by calling: Mustard.Worker.start_link(arg)
      # {Mustard.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mustard.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
