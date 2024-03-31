defmodule Meta.HtmlTest do
  use ExUnit.Case, async: true

  defmodule Template do
    import Meta.Html

    def render do
      markup do
        table class: :flex, cellspacing: 30 do
          tr do
            for i <- 1..3 do
              td do
                text("Cell #{i}")
              end
            end
          end
        end

        div do
          text("Some Nested Content")
        end
      end
    end
  end

  test "rendering html" do
    assert Template.render() ==
             "<table class=\"flex\" cellspacing=\"30\"><tr><td>Cell 1</td><td>Cell 2</td><td>Cell 3</td></tr></table><div>Some Nested Content</div>"
  end
end
