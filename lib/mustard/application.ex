defmodule Mustard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    case Mustard.Sup.start_link() do
      {:ok, pid} ->
        :ok = :riak_core.register([{:vnode_module, Mustard.Vnode}])
        :ok = :riak_core_node_watcher.service_up(Mustard.Service, self())
        {:ok, pid}
      {:error, reason} ->
        Logger.error("Unable to start NoSlides supervisor because: #{inspect reason}")
        {:error, reason}
    end
  end
end
