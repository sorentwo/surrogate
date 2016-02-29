defmodule Surrogate.Mixfile do
  use Mix.Project

  def project do
    [app: :surrogate,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [mod: {Surrogate, []},
     applications: [:cowboy, :plug, :logger]]
  end

  defp deps do
    [{:redix, "~> 0.3"},
     {:plug, "~> 1.0"},
     {:cowboy, "~> 1.0"}]
  end
end
