defmodule Chapter9Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Chapter9

  test "StringsAndBinaries-1 only printable" do
    assert only_printable?('aBc[ ! %~')
    assert only_printable?([23, 197, 31]) == false
  end

  test "StringsAndBinaries-2 anagram" do
    assert anagram?("dozen", "dozen") == false
    assert anagram?("dozen", "zoned")
    assert anagram?("terrain", "trainer")
    assert anagram?("terrain", "brainer") == false
    assert anagram?("", "") == false
  end

  test "StringsAndBinaries-4 calculate" do
    assert calculate('123 + 27') == 150
    assert calculate('125 / 10') == 12.5
  end

  test "StringsAndBinaries-5 center" do
    assert capture_io(fn -> center(["cat", "zebra", "elephant"]) end) == """
        cat
       zebra
      elephant
      """

    assert capture_io(fn -> center(["cat", "zeßra", "elephant"]) end) == """
        cat
       zeßra
      elephant
      """

    assert capture_io(fn -> center(["cat", "zebra", "eleƒƒant∫"]) end) == """
         cat
        zebra
      eleƒƒant∫
      """
  end

  test "StringsAndBinaries-6 capitalize sentences" do
    assert capitalize_sentences("oh. a DOG. woof. ") == "Oh. A DOG. Woof. "
  end

  test "StringsAndBinaries-7" do
    assert read_sales_data("test/sales_data.csv") == [
        [ id: 123, ship_to: :NC, net_amount: 100.0 ],
        [ id: 124, ship_to: :OK, net_amount: 35.5 ],
        [ id: 125, ship_to: :TX, net_amount: 24.0 ],
        [ id: 126, ship_to: :TX, net_amount: 44.8 ],
        [ id: 127, ship_to: :NC, net_amount: 25.0 ],
        [ id: 128, ship_to: :MA, net_amount: 10.0 ],
        [ id: 129, ship_to: :CA, net_amount: 102.0 ],
        [ id: 120, ship_to: :NC, net_amount: 50.0 ]]
  end
end
