defmodule Meta.AssertionTest do
  use ExUnit.Case, async: true

  alias Meta.Assertion
  alias ExUnit.CaptureIO

  import Assertion

  describe "expect/1" do
    test "==" do
      assert CaptureIO.capture_io(fn ->
               expect(7 == 7)
               expect(3 == 3)
               expect(1 == 5)
             end) == """
             ..
             FAILURE:
               Expected: 1
               to be equal to: 5
             """
    end

    test ">" do
      assert CaptureIO.capture_io(fn ->
               expect(7 > 6)
               expect(3 > 2)
               expect(1 > 5)
             end) == """
             ..
             FAILURE:
               Expected: 1
               to be greater than: 5
             """
    end
  end
end
