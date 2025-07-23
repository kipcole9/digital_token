defmodule Mix.Tasks.DigitalToken.Registry.Update do
  @moduledoc """
  Updates the digital token registry data.
  """

  use Mix.Task
  require Logger


  @shortdoc "Update digital token registry data"

  @url "https://download.dtif.org/data.json"

  @tokens_file_name DigitalToken.Decode.tokens_file_name()

  @doc false
  def run(_) do
    require Logger

    # Get auth token from environment variable
    auth_token = System.get_env("DTIF_AUTH_TOKEN")

    unless auth_token do
      Logger.error("Missing environment variable DTIF_AUTH_TOKEN. Please set it before running this task.")
      Mix.raise("Environment variable DTIF_AUTH_TOKEN is required")
    end

    # Convert headers to the format required by :httpc
    headers = [
      {~c"Authorization", ~c"Bearer #{auth_token}"},
      {~c"Accept", ~c"*/*"}
    ]

    # Ensure inets application is started
    :inets.start()
    :ssl.start()

    url = String.to_charlist(@url)
    request = {url, headers}
    http_options = [ssl: [{:verify, :verify_none}], timeout: 30000]
    options = [body_format: :binary]

    Logger.info "Fetching digital token registry from #{@url}"

    case :httpc.request(:get, request, http_options, options) do
      {:ok, {{_, 200, _}, response_headers, body}} ->
        Logger.info "Successfully retrieved digital token registry"
        Logger.debug "Response headers: #{inspect response_headers}"

        tokens =
          body
          |> DigitalToken.Decode.decode_tokens()
          |> :erlang.term_to_binary()

        File.write!(@tokens_file_name, tokens)
        Logger.info "Updated digital token registry at #{@tokens_file_name}"

      {:error, reason} ->
        Logger.warning "Failed to update digital token registry. #{inspect reason}"
    end
  end
end
