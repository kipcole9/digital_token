defmodule DigitalToken.Config do
  poison = if(Code.ensure_loaded?(Poison), do: Poison, else: nil)
  jason = if(Code.ensure_loaded?(Jason), do: Jason, else: nil)
  phoenix_json = Application.compile_env(:phoenix, :json_library)
  ecto_json = Application.compile_env(:ecto, :json_library)
  cldr_json = Application.compile_env(:ex_cldr, :json_library)
  digital_token_json = Application.compile_env(:digital_token, :json_library)
  @json_lib digital_token_json || cldr_json || phoenix_json || ecto_json || jason || poison

  cond do
    Code.ensure_loaded?(@json_lib) and function_exported?(@json_lib, :decode!, 1) ->
      :ok

    cldr_json ->
      raise ArgumentError,
            "Could not load configured :json_library, " <>
              "make sure #{inspect(cldr_json)} is listed as a dependency"

    true ->
      raise ArgumentError, """
      A JSON library has not been configured.\n
      Please configure a JSON lib in your `mix.exs`
      file. The suggested library is `:jason`.

      For example in your `mix.exs`:

          def deps() do
            [
              {:jason, "~> 1.0"},
              ...
            ]
          end

      You can then configure this library for `ex_cldr`
      in your `config.exs` as follows:

          config :ex_cldr,
            json_library: Jason

      If no configuration is provided, `ex_cldr` will
      attempt to detect any JSON library configured
      for Phoenix or Ecto then it will try to detect
      if Jason or Poison are configured.
      """
  end

  @doc """
  Return the configured json lib
  """
  def json_library do
    @json_lib
  end
end