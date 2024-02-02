defmodule MetaTest do
  use ExUnit.Case
  doctest Meta

  test "greets the world" do
    assert Meta.hello() == :world
  end
end
