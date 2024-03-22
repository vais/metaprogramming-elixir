defmodule Meta.HubTest do
  use ExUnit.Case, async: true

  alias Meta.Hub

  test "defines functions named after github repos and returning repo metadata" do
    repo = Hub.metaprogramming_elixir()
    assert repo["name"] == "metaprogramming-elixir"
    assert repo["full_name"] == "vais/metaprogramming-elixir"
  end
end
