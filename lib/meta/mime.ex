defmodule Meta.Mime do
  mime_types = Path.join(:code.priv_dir(:meta), "mime-types.txt")
  @external_resource mime_types

  defmacro __using__(opts) do
    for {type, exts} <- opts do
      quote do
        def exts_from_type(unquote(to_string(type))), do: unquote(exts)
      end
    end ++
      [
        quote do
          defdelegate exts_from_type(type), to: unquote(__MODULE__)
        end
      ]
  end

  for line <- File.stream!(mime_types, [], :line) do
    [type, rest] =
      line
      |> String.split("\t")
      |> Enum.map(&String.trim/1)

    exts =
      rest
      |> String.split(",")
      |> Enum.map(&String.trim/1)

    def exts_from_type(unquote(type)), do: unquote(exts)
    def type_from_ext(ext) when ext in unquote(exts), do: unquote(type)
  end

  def exts_from_type(_type), do: []
  def type_from_ext(_ext), do: nil

  def valid_type?(type), do: exts_from_type(type) |> Enum.any?()
  def valid_ext?(ext), do: !!type_from_ext(ext)
end
