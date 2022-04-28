defmodule HelloworksEx.V3.Workflow.WhiteLabel do
  use HelloworksEx

  defstruct white_label_id: nil

  alias HelloworksEx.V3.Auth.AuthToken
  alias Tesla.Multipart

  @type t :: __MODULE__

  @path "/v3/white_label/settings"

  @spec settings(
          AuthToken.t(),
          params ::
            %{
              optional(:white_label_id) => String.t(),
              :logo_file => String.t(),
              optional(:primary_color) => String.t(),
              optional(:logo_hidden) => String.t(),
              optional(:team_name) => String.t(),
              optional(:workflow_name) => String.t(),
              optional(:stepready_email_text) => String.t()
            }
        ) :: {:ok, t()}
  def settings(auth_token, params) do
    body =
      Multipart.new()
      |> Multipart.add_file(params.logo_file,
        name: :logo_file,
        filename: params.logo_file,
        headers: [{"content-type", "image/gif"}]
      )

    send_post(auth_token, @path, body)
  end
end
