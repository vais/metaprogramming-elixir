defmodule Meta.Html do
  @tags :code.priv_dir(:meta)
        |> Path.join("html-tags.json")
        |> File.read!()
        |> Jason.decode!()
        |> Enum.map(&String.to_atom/1)

  for t <- @tags do
    defmacro unquote(t)(attrs \\ [], do: block) do
      t = unquote(t)

      quote do
        tag(unquote(t), unquote(attrs), do: unquote(block))
      end
    end
  end

  defmacro markup(do: block) do
    quote do
      var!(buff, unquote(__MODULE__)) = start_buff()
      unquote(block)
      result = render_buff(var!(buff, unquote(__MODULE__)))
      :ok = stop_buff(var!(buff, unquote(__MODULE__)))
      result
    end
  end

  defmacro tag(t, attrs \\ [], do: block) do
    quote do
      put_buff(
        var!(buff, unquote(__MODULE__)),
        "<#{unquote(t)}#{stringify_attrs(unquote(attrs))}>"
      )

      unquote(block)
      put_buff(var!(buff, unquote(__MODULE__)), "</#{unquote(t)}>")
    end
  end

  defmacro text(str) do
    quote do
      put_buff(var!(buff, unquote(__MODULE__)), unquote(str))
    end
  end

  def stringify_attrs(attrs) do
    attrs
    |> Enum.map(fn {k, v} -> " #{k}=\"#{v}\"" end)
    |> Enum.join()
  end

  def start_buff() do
    {:ok, pid} = Agent.start_link(fn -> [] end)
    pid
  end

  def stop_buff(pid) do
    Agent.stop(pid)
  end

  def put_buff(pid, str) do
    Agent.update(pid, fn list -> [str | list] end)
  end

  def render_buff(pid) do
    pid
    |> Agent.get(fn list -> list end)
    |> Enum.reverse()
    |> Enum.join()
  end
end
