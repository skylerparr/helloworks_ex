defmodule HelloworksEx.Config.Config do
  @moduledoc false

  def api_id do
    Application.get_env(:helloworks_ex, :api_id)
  end

  def api_key do
    Application.get_env(:helloworks_ex, :api_key)
  end

  def base_url do
    Application.get_env(:helloworks_ex, :base_url)
  end
end
