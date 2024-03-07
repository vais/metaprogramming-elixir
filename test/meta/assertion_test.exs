defmodule Meta.AssertionTest do
  use ExUnit.Case, async: true

  alias ExUnit.CaptureIO

  describe "asserting/1" do
    import Meta.Assertion

    test "equal" do
      assert asserting(5 == 5) == :ok

      assert asserting(1 == 5) ==
               {:fail,
                """
                Expected: 1
                to be equal to: 5
                """}
    end

    test "greater than" do
      assert asserting(5 > 1) == :ok

      assert asserting(1 > 5) ==
               {:fail,
                """
                Expected: 1
                to be greater than: 5
                """}
    end
  end

  describe "testing/0" do
    test "success" do
      defmodule Success do
        use Meta.Assertion

        testing "integers can be added and subtracted" do
          asserting(1 + 1 == 2)
          asserting(2 + 3 == 5)
          asserting(5 - 5 == 0)
        end

        testing "integers can be multiplied and divided" do
          asserting(5 * 5 == 25)
          asserting(10 / 2 == 5)
        end
      end

      assert CaptureIO.capture_io(&Success.run/0) == """
             ..
             """
    end

    test "failure" do
      defmodule Failure do
        use Meta.Assertion

        testing "integers can be added" do
          asserting(1 + 1 == 2)
          asserting(2 + 3 == 5)
        end

        testing "integers can be subtracted" do
          asserting(15 - 5 == 10)
          asserting(5 - 5 == 10)
        end

        testing "integers can be multiplied" do
          asserting(5 * 5 == 25)
          asserting(10 * 2 == 20)
        end

        testing "integers can be divided" do
          asserting(5 / 5 == 1)
          asserting(10 / 2 == 5)
        end
      end

      assert CaptureIO.capture_io(&Failure.run/0) == """
             .
             ===============================================
             FAILURE: integers can be subtracted
             ===============================================
             Expected: 0
             to be equal to: 10
             ..
             """
    end
  end
end
