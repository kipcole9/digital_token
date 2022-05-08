defmodule Mix.Tasks.DigitalToken.Registry.Update do
  @moduledoc """
  Updates the digital token registry data.
  """

  use Mix.Task
  require Logger

  @shortdoc "Update digital token registry data"

  @url "https://download.dtif.org/data.json"
  @priv_dir Application.app_dir(:digital_token, "priv")
  @output_file_name Path.join(@priv_dir, "digital_token_registry.json")

  @doc false
  def run(_) do
    require Logger

    case Cldr.Http.get(@url) do
      {:ok, body} ->
        File.write!(@output_file_name, body)
        Logger.info "Updated digital token registry at #{@output_file_name}"

      {:error, reason} ->
        Logger.warning "Failed to update digital token registry. #{inspect reason}"
    end
  end
end

