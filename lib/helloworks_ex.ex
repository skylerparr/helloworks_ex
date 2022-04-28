defmodule HelloworksEx do
  defmacro __using__(_) do
    quote do
      alias HelloworksEx.Config.Config

      defp client(token) do
        middleware = [
          {Tesla.Middleware.BaseUrl, Config.base_url()},
          {Tesla.Middleware.Headers, [{"Authorization", "Bearer #{token.token}"}]},
          {Tesla.Middleware.Timeout, [timeout: 120_000]},
          Tesla.Middleware.JSON
        ]

        Tesla.client(middleware)
      end

      defp send_post(auth_token, path, params) do
        auth_token
        |> client()
        |> Tesla.post(path, params)
        |> case do
          {:ok,
           %Tesla.Env{
             status: 200,
             body: %{"data" => body}
           }} ->
            {:ok, body}
          e ->
            e
        end
      end
    end
  end
end
