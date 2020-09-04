defmodule Mustard.Vnode do
  require Logger
  @behaviour :riak_core_vnode

  def start_vnode(partition) do
    :riak_core_vnode_master.get_vnode_pid(partition, __MODULE__)
  end

  def init([partition]) do
    {:ok, %{partition: partition}}
  end

  def handle_command({:ping, v}, _sender, state = %{partition: partition}) do
    Logger.info("got a ping request!")
    {:reply, {:pong, v + 1, node(), partition}, state}
  end

  def handoff_starting(_dest, state) do
    Logger.info("handoff_starting")
    {true, state}
  end

  def handoff_cancelled(state) do
    Logger.info("handoff_cancelled")
    {:ok, state}
  end

  def handoff_finished(_dest, state) do
    Logger.info("handoff_finished")
    {:ok, state}
  end

  def handle_handoff_command(_fold_req, _sender, state) do
    Logger.info("handle_handoff_command")
    {:noreply, state}
  end

  def is_empty(state) do
    {true, state}
  end

  def terminate(_reason, _state) do
    :ok
  end

  def delete(state) do
    {:ok, state}
  end

  def handle_handoff_data(_bin_data, state) do
    Logger.info("handle_handoff_data")
    {:reply, :ok, state}
  end

  def encode_handoff_item(_k, _v) do
    Logger.info("encode_handoff")
    ""
  end

  def handle_coverage(_req, _key_spaces, _sender, state) do
    {:stop, :not_implemented, state}
  end

  def handle_exit(_pid, _reason, state) do
    {:noreply, state}
  end

  def handle_overload_command(_, _, _) do
    :ok
  end

  def handle_overload_info(_, _idx) do
    :ok
  end

  def terminate(_reason, _state) do
    Logger.info("terminate")
    :ok
  end
end
