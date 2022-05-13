defmodule DigitalToken.Data do
  @moduledoc false

  # This module exists to encapsulate data
  # the is used elsewhere.

  @tokens DigitalToken.Decode.data()

  def tokens do
    @tokens
  end

  @short_names DigitalToken.Decode.short_names(@tokens)

  def short_names do
    @short_names
  end

  # Create a mapping from token_is to a symbol

  @priv_dir Application.app_dir(:digital_token, "priv")
  @symbols_file_name Path.join(@priv_dir, "digital_token_symbols.json")

  def symbols do
    @symbols_file_name
    |> File.read!
    |> Jason.decode!
    |> Cldr.Map.atomize_keys()
    |> Enum.map(fn token ->
      with {:ok, token_id} <- Map.fetch(@short_names, token.symbol) do
        {token_id, token.usym}
      else
        _other -> nil
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> Map.new
  end
end