defmodule Chapter11Test do
  use ExUnit.Case

  @answers_to_twenty [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]

  test "FizzBuzz cond implementations" do
    alias Chapter11.FizzBuzzCond, as: FB

    assert FB.Simple.upto(20) == @answers_to_twenty
    assert FB.NumbersInReverse.upto(20) == @answers_to_twenty
    assert FB.UsingEnumMap.upto(20) == @answers_to_twenty
  end

  test "FizzBuzz functions implementation" do
    assert Chapter11.FizzBuzzFunc.upto(20) == @answers_to_twenty
  end

  test "ControlFlow-1 FizzBuzz with case" do
    assert Chapter11.FizzBuzzCase.upto(20) == @answers_to_twenty
  end

  test "ok!" do
    import Chapter11

    assert ok!(File.open("/Users/chris/.zshrc"))
    assert_raise RuntimeError, "Failure: enoent", fn -> ok!(File.open("/Users/foo/bar")) end
  end
end
