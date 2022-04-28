defmodule HelloworksExTest do
  use ExUnit.Case
  doctest HelloworksEx

  test "greets the world" do
    assert HelloworksEx.hello() == :world
  end
end
