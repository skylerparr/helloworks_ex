defmodule HelloworksEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :helloworks_ex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19", only: [:dev], runtime: false},
      {:credo, "~> 1.0", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.10", only: [:test]},
      {:syringe, "~> 1.1"},
      {:jason, "~> 1.0"},
      {:tesla, "~> 1.4.0"},
      {:hackney, "~> 1.16.0"}
    ]
  end
end
