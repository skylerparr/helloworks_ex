import Config

config :syringe, injector_strategy: AliasInjectingStrategy
config :helloworks_ex, base_url: System.get_env("HELLOWORKS_BASE_URL")
config :helloworks_ex, api_id: System.get_env("HELLOWORKS_API_ID")
config :helloworks_ex, api_key: System.get_env("HELLOWORKS_API_KEY")


