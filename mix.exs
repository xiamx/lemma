defmodule Lemma.Mixfile do
  use Mix.Project

  def project do
    [app: :lemma,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),

     # Docs
     name: "Lemma",
     source_url: "https://github.com/xiamx/lemma",
     homepage_url: "https://github.com/xiamx/lemma",
     docs: [main: "Lemma", # The main page in the docs
            extras: ["README.md"]]
    ]
  end

  defp package do
    [
      name: "lemma",
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      licenses: ["Apache 2.0"],
      maintainers: ["Meng Xuan Xia <mengxuan.xia@outlook.com>"],
      links: %{"GitHub" => "https://github.com/xiamx/lemma"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:gen_fst, "~> 0.4.1"},
      {:benchee, "~> 0.9", only: :dev},
      {:exprof, "~> 0.2.0", only: :dev},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end
end
