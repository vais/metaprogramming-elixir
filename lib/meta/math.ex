defmodule Meta.Math do
  defmacro say({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Meta.Math.Impl.say(operator, lhs, rhs)
    end
  end

  defmodule Impl do
    def say(:+, lhs, rhs) do
      "#{lhs} plus #{rhs} is #{lhs + rhs}"
    end

    def say(:*, lhs, rhs) do
      "#{lhs} times #{rhs} is #{lhs * rhs}"
    end
  end
end
