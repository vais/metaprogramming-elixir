defmodule Meta.SetterTest do
  use ExUnit.Case, async: true

  alias Meta.Setter
  require Setter

  describe "bind_name/1" do
    test "can override a variable that has been previously defined by the caller" do
      name = "Alice"
      assert name == "Alice"

      Setter.bind_name("Bob")
      assert name == "Bob"
    end
  end
end
