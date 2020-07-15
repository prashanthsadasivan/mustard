defmodule MustardTest do
  use ExUnit.Case
  doctest Mustard

  test "greets the world" do
    assert Mustard.hello() == :world
  end
end
