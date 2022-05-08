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

end