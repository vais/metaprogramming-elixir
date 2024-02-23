defmodule Meta.ControlFlowTest do
  use ExUnit.Case, async: true

  alias Meta.ControlFlow
  require ControlFlow

  describe "unless/2" do
    test "executes the do block when condition is falsey" do
      result =
        ControlFlow.unless nil do
          "this is the do block"
        end

      assert result == "this is the do block"
    end

    test "returns nil when condition is truthy" do
      result =
        ControlFlow.unless 123 do
          "this is the do block"
        end

      assert result == nil
    end

    test "executes the else block when condition is truthy" do
      result =
        ControlFlow.unless "hi" do
          "this is the do block"
        else
          "this is the else block"
        end

      assert result == "this is the else block"
    end
  end

  describe "my_if/2" do
    test "executes the do block when condition is truthy" do
      result =
        ControlFlow.my_if 123 do
          "this is the do block"
        end

      assert result == "this is the do block"
    end

    test "returns nil when condition is falsey" do
      result =
        ControlFlow.my_if nil do
          "this is the do block"
        end

      assert result == nil
    end

    test "executes the else block when condition is falsey" do
      result =
        ControlFlow.my_if nil do
          "this is the do block"
        else
          "this is the else block"
        end

      assert result == "this is the else block"
    end
  end
end
