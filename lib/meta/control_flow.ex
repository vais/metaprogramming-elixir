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

  defmacro my_if(condition, clauses) do
    build_if(condition, clauses)
  end

  defp build_if(condition, do: do_block) do
    build_if(condition, do: do_block, else: nil)
  end

  defp build_if(condition, do: do_block, else: else_block) do
    quote do
      case unquote(condition) do
        false -> unquote(else_block)
        nil -> unquote(else_block)
        _ -> unquote(do_block)
      end
    end
  end

  defmacro while(condition, do: block) do
    quote do
      try do
        for _ <- Stream.cycle([nil]) do
          if unquote(condition), do: unquote(block), else: break()
        end
      catch
        :break -> nil
      end
    end
  end

  def break, do: throw(:break)
end
