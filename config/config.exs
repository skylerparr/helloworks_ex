import Config

config :tesla, :adapter, Tesla.Adapter.Ibrowse

import_config "#{Mix.env()}.exs"
