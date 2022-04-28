defmodule HelloworksEx.V3.Auth.AuthToken do
  @moduledoc false

  defstruct expires_at: nil, token: nil

  use Tesla

  alias HelloworksEx.Config.Config
  alias __MODULE__

  @type t :: __MODULE__
  @type response :: map()

  @path "/v3/token/"

  plug(Tesla.Middleware.BaseUrl, Config.base_url())
  plug(Tesla.Middleware.Headers, [{"Authorization", "Bearer #{Config.api_key()}"}])
  plug(Tesla.Middleware.JSON)

  @spec get() :: {:ok, t()} | {:error, response}
  def get() do
    case get(@path <> Config.api_id()) do
      {:ok,
       %Tesla.Env{
         body: %{
           "data" => %{
             "expires_at" => expires_at,
             "token" => token
           }
         }
       }} ->
        {:ok, %__MODULE__{expires_at: expires_at, token: token}}
    end
  end
end
