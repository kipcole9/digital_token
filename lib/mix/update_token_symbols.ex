defmodule Mix.Tasks.DigitalToken.Symbols.Update do
  @moduledoc """
  Updates the digital token symbols data.

  Data is copied from [Crypto Currency Symbols](https://github.com/yonilevy/crypto-currency-symbols).

  """

  use Mix.Task
  require Logger

  @shortdoc "Update digital token symbol data"

  @url "https://raw.githubusercontent.com/yonilevy/crypto-currency-symbols/master/symbols.json"
  @priv_dir Application.app_dir(:digital_token, "priv")
  @output_file_name Path.join(@priv_dir, "digital_token_symbols.json")

  @doc false
  def run(_) do
    require Logger

    case Cldr.Http.get(@url) do
      {:ok, body} ->
        File.write!(@output_file_name, body)
        Logger.info "Updated digital token symbols at #{@output_file_name}"

      {:error, reason} ->
        Logger.warning "Failed to update digital token symbols. #{inspect reason}"
    end
  end
end

