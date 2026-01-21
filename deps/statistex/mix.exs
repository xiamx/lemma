defmodule Statistex.MixProject do
  use Mix.Project

  @version "1.0.0"
  def project do
    [
      app: :statistex,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        source_ref: @version,
        extras: ["README.md"],
        main: "readme"
      ],
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.travis": :test,
        "safe_coveralls.travis": :test
      ],
      dialyzer: [
        flags: [:unmatched_returns, :error_handling, :race_conditions, :underspecs]
      ],
      name: "Statistex",
      source_url: "https://github.com/bencheeorg/statistex",
      description: """
      Calculate statistics on data sets, reusing previously calculated values or just all metrics at once. Part of the benchee library family.
      """
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.20.0", only: :dev},
      {:earmark, "~> 1.0", only: :dev},
      {:excoveralls, "~> 0.7", only: :test},
      # dev and test so that the formatter has access
      {:stream_data, "~> 0.4", only: [:dev, :test]},
      {:inch_ex, "~> 2.0", only: :docs},
      {:dialyxir, "~> 1.0.0-rc.4", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Tobias Pfeiffer"],
      licenses: ["MIT"],
      links: %{
        "github" => "https://github.com/bencheeorg/statistex"
      }
    ]
  end
end
