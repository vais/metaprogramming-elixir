defmodule Meta.Assertion do
  defmacro asserting({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Meta.Assertion.Test.asserting(operator, lhs, rhs)
    end
  end

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
      @before_compile unquote(__MODULE__)

      Module.register_attribute(__MODULE__, :tests, accumulate: true)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run(), do: Meta.Assertion.Test.run(@tests, __MODULE__)
    end
  end

  defmacro testing(description, do: function_body) do
    function_name = String.to_atom(description)

    quote do
      @tests {unquote(function_name), unquote(description)}
      def unquote(function_name)(), do: unquote(function_body)
    end
  end

  defmodule Test do
    def run(tests, module) do
      for {function, description} <- Enum.reverse(tests) do
        case apply(module, function, []) do
          :ok ->
            IO.write(".")

          {:fail, message} ->
            IO.write("""

            ===============================================
            FAILURE: #{description}
            ===============================================
            #{message |> String.trim_trailing("\n")}
            """)
        end
      end

      IO.write("\n")
    end

    def asserting(:==, lhs, rhs) when lhs == rhs, do: :ok

    def asserting(:==, lhs, rhs) do
      {:fail,
       """
       Expected: #{lhs}
       to be equal to: #{rhs}
       """}
    end

    def asserting(:>, lhs, rhs) when lhs > rhs, do: :ok

    def asserting(:>, lhs, rhs) do
      {:fail,
       """
       Expected: #{lhs}
       to be greater than: #{rhs}
       """}
    end
  end
end
