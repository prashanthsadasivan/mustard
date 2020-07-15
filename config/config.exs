use Mix.Config

node_name = "NODE_NAME"
            |> System.fetch_env!()
            |> to_charlist
web_port = "WEB_PORT"
           |> System.fetch_env!()
           |> String.to_integer()
handoff_port = "HANDOFF_PORT"
           |> System.fetch_env!()
           |> String.to_integer()

ring_state_dir = "ring_state_dir_#{node_name}"
                 |> to_charlist

platform_dir = "platform_dir_#{node_name}"
               |> to_charlist

config :riak_core,
  web_port: web_port,
  handoff_port: handoff_port,
  schema_dirs: ['priv'],
  ring_creation_size: 12,
  vnode_inactivity_timeout: 1000,
  ring_state_dir: ring_state_dir,
  platform_data_dir: platform_dir

config :lager,
  colored: true,
  error_logger_hwm: 500

config :sasl,
  errlog_type: :error
