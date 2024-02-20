defmodule Meta.ControlFlow do
  defmacro unless(condition, do: do_block) do
    quote do
      if !unquote(condition), do: unquote(do_block)
    end
  end

  defmacro unless(condition, do: do_block, else: else_block) do
    quote do
      if unquote(condition), do: unquote(else_block), else: unquote(do_block)
    end
  end
end
