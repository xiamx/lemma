defmodule GenFST.Mixfile do
  use Mix.Project

  def project do
    [app: :gen_fst,
     version: "0.4.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     docs: [main: "GenFST"],
     source_url: "https://github.com/xiamx/gen_fst",
     homepage_url: "https://github.com/xiamx/gen_fst",
     deps: deps()]
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
      {:gen_state_machine, "~> 2.0"},
      {:libgraph, "~> 0.9"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    GenFST implements a generic finite state transducer
    with customizable rules elegantly expressed in a DSL.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :gen_fst,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Meng Xuan Xia"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/xiamx/gen_fst"}
    ]
  end
end
