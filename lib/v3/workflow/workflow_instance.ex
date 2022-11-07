defmodule HelloworksEx.V3.Workflow.WorkflowInstance do
  use HelloworksEx

  defstruct audit_trail_hash: nil,
            type: nil,
            data: nil,
            document_hashes: nil,
            id: nil,
            mode: nil,
            status: nil,
            workflow_id: nil

  alias HelloworksEx.V3.Auth.AuthToken
  alias HelloworksEx.Config.Config

  @type t :: __MODULE__
  @type participant_id :: String.t()
  @type merge_field_name :: String.t()

  @path "/v3/workflow_instances/"

  @spec get(AuthToken.t(), String.t()) :: {:ok, t()} | {:error, :workflow_not_found}
  def get(auth_token, workflow_instance_id) do
    auth_token
    |> client()
    |> Tesla.get(@path <> workflow_instance_id)
    |> case do
      {:ok,
       %Tesla.Env{
         body: %{"data" => body}
       }} ->
        {:ok,
         %__MODULE__{
           type: body["type"],
           audit_trail_hash: body["audit_trail_hash"],
           data: body["data"],
           document_hashes: body["document_hashes"],
           id: body["id"],
           mode: body["mode"],
           status: body["status"],
           workflow_id: body["workflow_id"]
         }}

      {:ok, %Tesla.Env{status: 404}} ->
        {:error, :workflow_not_found}
    end
  end

  @spec create(
          AuthToken.t(),
          params :: %{
            :workflow_id => String.t(),
            :participants => %{
              participant_id => %{
                :type => String.t(),
                :value => String.t(),
                :full_name => String.t()
              }
            },
            optional(:merge_fields) => %{
              merge_field_name => String.t()
            },
            optional(:callback_url) => String.t(),
            optional(:redirect_url) => String.t(),
            optional(:document_delivery) => true | false,
            optional(:white_label_id) => String.t(),
            optional(:delegated_authentication) => true | false,
            optional(:metadata) => %{
              String.t() => String.t()
            },
            optional(:document_delivery_type) => String.t(),
            optional(:notify_when_complete) => true | false
          }
        ) :: {:ok, t()}
  def create(auth_token, params) do
    send_post(auth_token, @path, params)
  end

  @spec preview(
          AuthToken.t(),
          params :: %{
            :workflow_id => String.t(),
            :participants => %{
              participant_id => %{
                :type => String.t(),
                :value => String.t(),
                :full_name => String.t()
              }
            },
            optional(:merge_fields) => %{
              merge_field_name => String.t()
            },
            optional(:callback_url) => String.t(),
            optional(:redirect_url) => String.t(),
            optional(:document_delivery) => true | false,
            optional(:white_label_id) => String.t(),
            optional(:delegated_authentication) => true | false,
            optional(:metadata) => %{
              String.t() => String.t()
            },
            optional(:document_delivery_type) => String.t(),
            optional(:notify_when_complete) => true | false
          }
        ) :: {:ok, t()}
  def preview(auth_token, params) do
    send_post(auth_token, "#{@path}preview/", params)
  end

  @spec get_audit_trail(AuthToken.t(), String.t()) ::
          {:ok, binary()} | {:error, :workflow_not_found}
  def get_audit_trail(auth_token, workflow_instance_id) do
    auth_token
    |> client()
    |> Tesla.get(@path <> workflow_instance_id <> "/audit_trail")
    |> case do
      {:ok,
       %Tesla.Env{
         body: body,
         status: 200
       }} ->
        {:ok, body}

      {:ok, %Tesla.Env{status: 404}} ->
        {:error, :workflow_not_found}
    end
  end

  @spec get_workflow_instance_document(AuthToken.t(), String.t(), String.t()) ::
          {:ok, binary()} | {:error, :workflow_instance_not_found}
  def get_workflow_instance_document(auth_token, workflow_instance_id, document_id) do
    auth_token
    |> client()
    |> Tesla.get(@path <> workflow_instance_id <> "/documents/#{document_id}")
    |> case do
      {:ok,
       %Tesla.Env{
         body: body,
         status: 200
       }} ->
        {:ok, body}

      {:ok, %Tesla.Env{status: 404}} ->
        {:error, :workflow_not_found}
    end
  end
end
