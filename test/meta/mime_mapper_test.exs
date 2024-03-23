defmodule Meta.MimeMapperTest do
  use ExUnit.Case, async: true

  alias Meta.MimeMapper

  describe "exts_from_type/1" do
    test "with default configuration" do
      assert MimeMapper.exts_from_type("application/javascript") == [".js"]
    end

    test "with custom configuration" do
      assert MimeMapper.exts_from_type("text/elixir") == [".exs"]
      assert MimeMapper.exts_from_type("text/emoji") == [".emj"]
    end
  end
end
