defmodule Astarte.Streams.MixProject do
  use Mix.Project

  def project do
    [
      app: :astarte_streams,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Astarte.Streams.Application, []}
    ]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end
end
