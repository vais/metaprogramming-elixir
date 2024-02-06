defmodule Meta.MathTest do
  use ExUnit.Case, async: true

  alias Meta.Math
  require Math

  describe "say/1" do
    test "converts math expression to spoken form" do
      assert Math.say(5 + 2) == "5 plus 2 is 7"
      assert Math.say(18 * 4) == "18 times 4 is 72"
    end
  end
end
