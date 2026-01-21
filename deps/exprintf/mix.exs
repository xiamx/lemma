defmodule ExPrintf.Mixfile do
  use Mix.Project

  def project do
    [ app: :exprintf,
      version: "0.2.1",
      elixir: "~> 1.0",
      deps: deps(),
      description: description(),
      package: package()
    ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
    """
    A printf / sprintf library for Elixir. It works as a wrapper for :io.format.
    """
  end

  defp package do
    [ maintainers: ["parroty"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/parroty/exprintf"} ]
  end
end
