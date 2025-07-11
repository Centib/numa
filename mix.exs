defmodule Numa.MixProject do
  use Mix.Project

  @source_url "https://github.com/Centib/numa"
  @version "0.1.0"

  def project do
    [
      app: :numa,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: "A tiny Elixir library for defining enum-like macros with helpers",
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
      organization: "Centib",
      maintainers: ["Zoran Radovanovic"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url},
      files: ~w(.formatter.exs mix.exs README.md LICENSE.md lib assets/logo.png)
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE.md"],
      source_ref: "v#{@version}",
      source_url: @source_url,
      logo: "assets/logo.png"
    ]
  end
end
