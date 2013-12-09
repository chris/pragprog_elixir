defmodule Chapter11 do
  defmodule FizzBuzzCond do
    @moduledoc "A progression of FizzBuzz implementations using cond"

    defmodule Simple do
      def upto(n) when n > 0, do: _upto(1, n, [])

      defp _upto(_current, 0, result), do: Enum.reverse result
      defp _upto(current, left, result) do
        next_answer =
          cond do
            rem(current, 3) == 0 and rem(current, 5) == 0 -> "FizzBuzz"
            rem(current, 3) == 0 -> "Fizz"
            rem(current, 5) == 0 -> "Buzz"
            true -> current
          end
        _upto(current + 1, left - 1, [ next_answer | result ])
      end
    end

    defmodule NumbersInReverse do
      @moduledoc "FizzBuzz using cond, and processing numbers from last to first"

      def upto(n) when n > 0, do: _downto(n, [])

      defp _downto(0, result), do: result
      defp _downto(current, result) do
        next_answer =
          cond do
            rem(current, 3) == 0 and rem(current, 5) == 0 -> "FizzBuzz"
            rem(current, 3) == 0 -> "Fizz"
            rem(current, 5) == 0 -> "Buzz"
            true -> current
          end
        _downto(current - 1, [ next_answer | result ])
      end
    end

    defmodule UsingEnumMap do
      def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

      defp fizzbuzz(n) do
        cond do
          rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
          rem(n, 3) == 0 -> "Fizz"
          rem(n, 5) == 0 -> "Buzz"
          true -> n
        end
      end
    end
  end # module FizzBuzzCond


  defmodule FizzBuzzFunc do
    @moduledoc "Fizz Buzz done using all functions, no conditionals"

    def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

    defp fizzbuzz(n) when rem(n,3) == 0 and rem(n,5) == 0, do: "FizzBuzz"
    defp fizzbuzz(n) when rem(n,3) == 0, do: "Fizz"
    defp fizzbuzz(n) when rem(n,5) == 0, do: "Buzz"
    defp fizzbuzz(n), do: n
  end


  defmodule FizzBuzzCase do
    @moduledoc "Fizz Buzz implemented with case"

    def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

    defp fizzbuzz(n) do
      case { rem(n, 3), rem(n, 5), n } do
        { 0, 0, _ } -> "FizzBuzz"
        { 0, _, _ } -> "Fizz"
        { _, 0, _ } -> "Buzz"
        _ -> n
      end
    end
  end

  def ok!({:ok, data}), do: data
  def ok!({_, error}), do: raise "Failure: #{error}"
end
