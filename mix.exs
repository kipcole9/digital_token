defmodule DigitalToken.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :digital_token,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:cldr_utils, "~> 2.17", only: :dev},
      {:jason, "~> 1.0"}
    ]
  end
end
