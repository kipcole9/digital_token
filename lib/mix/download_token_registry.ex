defmodule Mix.Tasks.DigitalToken.Registry.Download do
  @moduledoc """
  Downloads the digital token registry
  """

  use Mix.Task
  require Logger

  @shortdoc "Download digital token registry"

  @url "https://download.dtif.org/data.json"
  @priv_dir Application.app_dir(:digital_token, "priv")
  @output_file_name Path.join(@priv_dir, "digital_token_registry.json")

  @doc false
  def run(_) do
    require Logger

    case Cldr.Http.get(@url) do
      {:ok, body} ->
        File.write!(@output_file_name, body)
        Logger.info "Downloaded digital token registry to #{@output_file_name}"

      {:error, reason} ->
        Logger.warning "Failed to download digital token registry. #{inspect reason}"
    end
  end
end

