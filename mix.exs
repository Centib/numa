defmodule Numa.MixProject do
  use Mix.Project

  @source_url "https://github.com/Centib/numa"
  @version "0.1.1"

  def project do
    [
      app: :numa,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: "Lightweight compile-time symbolic constants for Elixir using macros.",
      package: package(),

      # Docs
      name: "Numa",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7.12", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.38.1", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["gnjec (Centib)"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      files: ~w(.formatter.exs mix.exs README.md CHANGELOG.md LICENSE.md lib),
      keywords: ["enum", "const", "macro", "elixir", "helpers"]
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "CHANGELOG.md", "LICENSE.md"],
      source_ref: "v#{@version}",
      source_url: @source_url,
      logo: "assets/logo.svg"
    ]
  end
end
