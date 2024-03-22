defmodule Meta.Hub do
  Application.ensure_all_started([:telemetry])
  Finch.start_link(name: Req.Finch)

  "https://api.github.com/users/vais/repos"
  |> Req.get!()
  |> Map.get(:body)
  |> Enum.each(fn repo ->
    repo["name"]
    |> String.replace(~r/[^a-zA-Z0-9]/, "_")
    |> String.to_atom()
    |> then(fn name ->
      def unquote(name)() do
        unquote(Macro.escape(repo))
      end
    end)
  end)

  def go(repo_name) do
    repo = apply(__MODULE__, repo_name, [])
    url = repo["html_url"]
    System.cmd("open", [url])
  end
end
