defmodule Meta.Assertion do
  defmacro expect({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Meta.Assertion.Test.expect(operator, lhs, rhs)
    end
  end

  defmodule Test do
    def expect(:==, lhs, rhs) when lhs == rhs do
      IO.write(".")
    end

    def expect(:==, lhs, rhs) do
      IO.puts("\nFAILURE:")
      IO.puts("  Expected: #{lhs}")
      IO.puts("  to be equal to: #{rhs}")
    end

    def expect(:>, lhs, rhs) when lhs > rhs do
      IO.write(".")
    end

    def expect(:>, lhs, rhs) do
      IO.puts("\nFAILURE:")
      IO.puts("  Expected: #{lhs}")
      IO.puts("  to be greater than: #{rhs}")
    end
  end
end
