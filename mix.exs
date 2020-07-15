defmodule Mustard.MixProject do
  use Mix.Project

  def project do
    [
      app: :mustard,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:riak_core, :logger],
      mod: {Mustard.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:eleveldb, git: "git://github.com/basho/eleveldb", tag: "develop-3.0", override: true},
      {:uniendo, git: "git://github.com/marianoguerra/uniendo.git", branch: "master"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
