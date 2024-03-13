defmodule Meta.MimeTest do
  use ExUnit.Case, async: true

  alias Meta.Mime

  describe "exts_from_type/1" do
    test "returns a list of file extensions for a known mime type" do
      assert Mime.exts_from_type("image/jpeg") == [".jpeg", ".jpg"]
    end

    test "returns an empty list for an unknown mime type" do
      assert Mime.exts_from_type("hi") == []
    end
  end

  describe "type_from_ext/1" do
    test "returns mime type for a known file extension" do
      assert Mime.type_from_ext(".jpg") == "image/jpeg"
    end

    test "returns nil for an unknown file extension" do
      assert Mime.type_from_ext(".what") == nil
    end
  end

  describe "valid_type?/1" do
    test "true if given type is known" do
      assert Mime.valid_type?("application/json") == true
    end

    test "false if given type is unknown" do
      assert Mime.valid_type?("application/jason") == false
    end
  end

  describe "valid_ext?/1" do
    test "true if given extension is known" do
      assert Mime.valid_ext?(".jpgv") == true
    end

    test "false if given extension is unknown" do
      assert Mime.valid_ext?(".argv") == false
    end
  end
end
