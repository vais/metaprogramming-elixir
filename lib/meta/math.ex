defmodule Meta.Math do
  defmacro say({:+, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      res = lhs + rhs
      "#{lhs} plus #{rhs} is #{res}"
    end
  end

  defmacro say({:*, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      res = lhs * rhs
      "#{lhs} times #{rhs} is #{res}"
    end
  end
end
