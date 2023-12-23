defmodule AlchemyMarkdownTest do
  use ExUnit.Case
  doctest AlchemyMarkdown

  test "italicizes" do
    str = "Something *important*"
    assert AlchemyMarkdown.earmarks(str) =~ "Something <em>important</em>"
  end

  test "expand big tags" do
    str = "Some ++big++ words!"
    assert AlchemyMarkdown.big(str) =~ "<big>big</big>"
  end

  test "expand small tags" do
    str = "Some --small-- words!"
    assert AlchemyMarkdown.small(str) =~ "<small>small</small>"
  end

  test "expands hr tags" do
    str1 = "Stuff over the line\n---"
    str2 = "Stuff over the line\n***"
    str3 = "Stuff over the line\n- - -"
    str4 = "Stuff over the line\n*    *    *"
    str5 = "Stuff over the line*    *    *"

    Enum.map(
      [str1, str2, str3, str4],
      fn text -> assert AlchemyMarkdown.hrs(text) == "Stuff over the line\n<hr />" end
    )

    assert AlchemyMarkdown.hrs(str5) == str5
  end
end
