defmodule Meta.Translator do
  defmacro __using__(_args) do
    quote do
      Module.register_attribute(__MODULE__, :locales, accumulate: true)
      import unquote(__MODULE__), only: [locale: 2]
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro locale(locale, mappings) do
    quote do
      @locales {unquote(locale), unquote(mappings)}
    end
  end

  defmacro __before_compile__(env) do
    quote do
      def t(locale, path, bindings \\ [])

      unquote(
        for {locale, mappings} <- Module.get_attribute(env.module, :locales) do
          define_translations(locale, "", mappings)
        end
      )

      def t(_locale, _path, _bindings), do: {:error, :no_translation}
    end
  end

  defp define_translations(locale, path, mappings) do
    for {key, val} <- mappings do
      new_path = append_path(path, key)
      define_translation(locale, new_path, val)
    end
  end

  defp define_translation(locale, new_path, val) when is_list(val) do
    define_translations(locale, new_path, val)
  end

  defp define_translation(locale, new_path, {singular, plural}) do
    quote do
      def t(unquote(locale), unquote(new_path), bindings) do
        case Keyword.get(bindings, :count) do
          count when count in [nil, 1] -> unquote(interpolate(singular))
          _ -> unquote(interpolate(plural))
        end
      end
    end
  end

  defp define_translation(locale, new_path, val) do
    quote do
      def t(unquote(locale), unquote(new_path), bindings) do
        unquote(interpolate(val))
      end
    end
  end

  defp append_path("", segment), do: to_string(segment)
  defp append_path(path, segment), do: "#{path}.#{segment}"

  defp interpolate(text) do
    text
    |> String.split(~r/%\{[^}]+\}/, include_captures: true)
    |> Enum.reduce("", fn
      <<"%{" <> rest>>, acc ->
        key =
          rest
          |> String.trim_trailing("}")
          |> String.to_atom()

        ast =
          quote do
            to_string(Keyword.fetch!(bindings, unquote(key)))
          end

        concat(acc, ast)

      str, acc ->
        concat(acc, str)
    end)
  end

  defp concat("", str2), do: str2

  defp concat(str1, str2) do
    quote do: unquote(str1) <> unquote(str2)
  end
end
