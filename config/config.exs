import Config

config :tesla, :adapter, {Tesla.Adapter.Ibrowse, timeout: 120_000}

import_config "#{Mix.env()}.exs"
