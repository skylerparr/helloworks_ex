defmodule HelloworksEx.V3.Workflow.Workflows do
  use HelloworksEx

  defstruct guid: nil,
            name: nil,
            description: nil,
            merge_fields: nil,
            roles: nil

  alias HelloworksEx.V3.Auth.AuthToken
  alias HelloworksEx.Config.Config

  @type t :: __MODULE__

  @path "/v3/workflows"

  @spec list(AuthToken.t()) :: {:ok, t()}
  def list(auth_token) do
    auth_token
    |> client()
    |> Tesla.get(@path)
    |> case do
      {:ok,
       %Tesla.Env{
         body: %{"data" => body}
       }} ->
        workflows =
          Enum.into(body, [], fn body ->
            %__MODULE__{
              guid: body["guid"],
              name: body["name"],
              description: body["description"],
              merge_fields: body["merge_fields"],
              roles: body["roles"]
            }
          end)

        {:ok, workflows}

      {:ok, %Tesla.Env{status: 404}} ->
        {:error, :workflow_not_found}
    end
  end

  @spec download_workflow_csv(AuthToken.t(), String.t(), DateTime.t(), DateTime.t()) ::
          {:ok, binary()} | {:error, :worklow_not_found} | {:error, :forbidden}
  def download_workflow_csv(auth_token, workflow_id, start_date, end_date) do
    params = %{start_date: start_date, end_date: end_date}
    auth_token
    |> client()
    |> Tesla.post(@path <> "/#{workflow_id}/csv", params)
    |> case do
         {:ok,
           %Tesla.Env{
             status: 200,
             body: body
           }} ->
           {:ok, body}
      {:ok, %Tesla.Env{status: 403}} ->
        {:error, :forbidden}
      {:ok, %Tesla.Env{status: 404}} ->
        {:error, :workflow_not_found}
    end
  end
end
