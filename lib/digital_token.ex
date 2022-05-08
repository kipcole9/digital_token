defmodule DigitalToken do
  @moduledoc """
  Functions to validate, search and retrieve digital token
  data sourced from the [DTIF registry](https://dtif.org).

  """

  defstruct [
    header: nil,
    informative: nil,
    metadata: nil,
    normative: nil
  ]

  @typedoc """
  The structure of data matching that hosted in
  the [DTIF registry](https://dtif.org)/

  """
  @type t :: %__MODULE__{
    header: map(),
    informative: map(),
    metadata: map(),
    normative: map()
  }

  @typedoc """
  token_id is a random 9-character
  string defined by the [dtif registry](https://dtif.org)
  that uniquely identifies a digital token.

  """
  @type token_id :: String.t()

  @typedoc """
  A digital token may have zero of more short
  names associated with it. They are arbitrary
  strings, usually three or four characters in
  length. For example "BTC", "ETH" and "DOGE".

  """
  @type short_name :: String.t()

  @typedoc """
  A mapping of digital token identifiers
  to the registry data for that token.

  """
  @type token_map :: %{
    token_id() => t()
  }

  @typedoc """
  A mapping from a short name to token
  identifier.

  """
  @type short_name_map :: %{
    short_name() => token_id()
  }

  @doc """
  Returns a map of the digital tokens in the
  [dtif registry](https://dtif.org).

  """
  @spec tokens :: token_map()
  def tokens do
    DigitalToken.Data.tokens()
  end

  @doc """
  Returns a mapping of digital token short
  names to digital token identifiers.

  """
  @spec short_names :: short_name_map()
  def short_names do
    DigitalToken.Data.short_names()
  end

  @doc """
  Validates a token identifier or short name
  and returns the token identifier or an error.

  ## Arguments

  * `id` is any token identifier or short name

  ## Returns

  * `{:ok, token_id}` or

  * `{:error, {exception, id}}`

  ## Example

      iex> DigitalToken.validate_token("BTC")
      {:ok, "4H95J0R2X"}

      iex> DigitalToken.validate_token("Bitcoin")
      {:ok, "4H95J0R2X"}

      iex> DigitalToken.validate_token "4H95J0R2X"
      {:ok, "4H95J0R2X"}

      iex> DigitalToken.validate_token("Nothing")
      {:error, {DigitalToken.UnknownTokenError, "Nothing"}}

  """
  @spec validate_token(token_id() | short_name()) ::
    {:ok, token_id()} | {:error, {module(), any()}}
  def validate_token(id) do
    cond do
      Map.has_key?(tokens(), id) ->
        {:ok, id}

      token = Map.get(short_names(), id) ->
        {:ok, token}

      id ->
        {:error, unknown_token_error(id)}
    end
  end

  @doc """
  Returns the registry data for a given token
  identifier.

  ## Arugments

  * `id` is any token identifier or short name

  ## Returns

  * `{:ok, registry_data}` or

  * `{:error, {exception, id}}`

  ## Example

      DigitalToken.get_token("BTC")
      #=> {:ok,
       %DigitalToken{
         header: %{
           dlt_type: :blockchain,
           dti: "4H95J0R2X",
           dti_type: :native,
           template_version: #Version<1.0.0>
         },
         informative: %{
           long_name: "Bitcoin",
           public_distributed_ledger_indication: false,
           short_names: ["BTC", "XBT"],
           unit_multiplier: 100000000,
           url: "https://github.com/bitcoin/bitcoin"
         },
         metadata: %{
           .....

  """
  @spec get_token(token_id() | short_name()) :: {:ok, t()} | {:error, {module(), any()}}
  def get_token(id) do
    with {:ok, token} <- validate_token(id) do
      {:ok, Map.fetch!(tokens(), token)}
    end
  end

  @doc """
  Returns the registry data for a given token
  identifier.

  ## Arugments

  * `id` is any token identifier or short name

  ## Returns

  * `registry_data` or

  * raises an exception

  ## Example

      DigitalToken.get_token("BTC")
      #=> %DigitalToken{
         header: %{
           dlt_type: :blockchain,
           dti: "4H95J0R2X",
           dti_type: :native,
           template_version: #Version<1.0.0>
         },
         informative: %{
           long_name: "Bitcoin",
           public_distributed_ledger_indication: false,
           short_names: ["BTC", "XBT"],
           unit_multiplier: 100000000,
           url: "https://github.com/bitcoin/bitcoin"
         },
         metadata: %{
           .....

  """
  @spec get_token!(token_id() | short_name()) :: t() | no_return()
  def get_token!(id) do
    case get_token(id) do
      {:ok, token} -> token
      {:error, {exception, id}} -> raise exception, id
    end
  end

  defp unknown_token_error(id) do
    {DigitalToken.UnknownTokenError, id}
  end
end
