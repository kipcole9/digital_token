defmodule DigitalToken.Config do
  @moduledoc false

  @doc """
  Return the json module. Always `:json` (OTP built-in).
  On OTP versions before 27, add `{:json_polyfill, "~> 0.1"}`
  as a dependency.

  """
  def json_library do
    :json
  end
end
