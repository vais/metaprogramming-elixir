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

  describe "while/2" do
    import ControlFlow, only: [while: 2, break: 0]

    test "evaluates block while condition evaluates truthy" do
      {:ok, pid} = Agent.start_link(fn -> 1 end)

      while (i = Agent.get_and_update(pid, &{&1, &1 + 1})) < 10 do
        if i > 3, do: break()
        send(self(), i)
      end

      assert {:messages, [1, 2, 3]} = :erlang.process_info(self(), :messages)
    end

    test "a different approach" do
      pid = spawn(fn -> Process.sleep(:infinity) end)

      send(self(), :one)

      while Process.alive?(pid) do
        receive do
          :one ->
            send(self(), :two)

          :two ->
            send(self(), :three)

          :three ->
            Process.exit(pid, :kill)
            send(self(), :done)
        end
      end

      assert_received :done
    end
  end
end
