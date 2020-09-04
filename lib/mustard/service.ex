defmodule Mustard.Service do
  def ping(v \\ 1) do
    doc_idx = :riak_core_util.chash_key({"ping", "ping_#{v}"})
    pref_list = :riak_core_apl.get_primary_apl(doc_idx, 2, Mustard.Service)
    [{n1, _type}, {n2, _type}] = pref_list
    # riak core appends "_master" to Mustard.Vnode.
    :riak_core_vnode_master.sync_spawn_command(n1, {:ping, v}, Mustard.Vnode_master)
  end
end
