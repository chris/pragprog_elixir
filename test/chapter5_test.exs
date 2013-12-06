defmodule Chapter5Test do
  use ExUnit.Case

  test "exercises chapter 5.1" do
    list_concat = fn list1, list2 -> (list1 ++ list2) end
    assert list_concat.([1,2,3], [4,5,6]) == [1,2,3,4,5,6]

    sum = fn a,b,c -> a + b + c end
    assert sum.(1,2,3) == 6

    pair_tuple_to_list = fn {a, b} -> [a,b] end
    assert pair_tuple_to_list.( { 8, 7 } ) == [8, 7]
  end

  test "exercises chapter 5.2" do
    # Write a function that takes three arguments. If the first two are zero, return “FizzBuzz”.
    # If the first is zero, return “Fizz”. If the second is zero return “Buzz”. Otherwise return
    # the third argument. Do not use any language features that we haven’t yet covered in this book.
    fizzbuzz = fn
      0, 0, _ -> "FizzBuzz"
      0, _, _ -> "Fizz"
      _, 0, _ -> "Buzz"
      _, _, x -> x
    end

    assert fizzbuzz.(0,0,0) == "FizzBuzz"
    assert fizzbuzz.(0,0,4) == "FizzBuzz"

    assert fizzbuzz.(0,3,0) == "Fizz"

    assert fizzbuzz.(5,0,0) == "Buzz"

    assert fizzbuzz.(1,1,9) == 9

    # The operator rem( a, b) returns the remainder after dividing a by b. Write a function that
    # takes a single integer (n) calls the function in the previous exercise, passing it
    # rem( n, 3), rem( n, 5), and n. Call it 7 times with the arguments 10, 11, 12, etc. You should
    # get “Buzz, 11, Fizz, 13, 14, FizzBuzz”, 16”. (Yes, it’s a FizzBuzz[ 9] solution with no
    # conditional logic).
    fizzbuzz = fn(n) -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

    assert [fizzbuzz.(10), fizzbuzz.(11), fizzbuzz.(12), fizzbuzz.(13), fizzbuzz.(14), fizzbuzz.(15), fizzbuzz.(16)] == ["Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16]
  end

  test "exercises chapter 5.2 Functions-4" do
    # Write a function prefix that takes a string. It should return a new function that takes a
    # second string. When that second function is called, it will return a string containing the
    # first string, a space, and the second string.

    prefix = fn str -> (fn str2 -> "#{str} #{str2}" end) end
    mrs = prefix.("Mrs")
    assert mrs.("Smith") == "Mrs Smith"

    assert prefix.("Elixir").("Rocks") == "Elixir Rocks"
  end

  test "exercises chapter 5.2 Functions-5" do
    assert Enum.map([1,2,3,4], &(&1 + 2)) == [3,4,5,6]
    Enum.each([1,2,3,4], &(IO.inspect &1))
  end
end
