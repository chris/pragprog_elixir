defmodule Chapter7.Lists do
  def sum([]), do: 0
  def sum([head|tail]) when is_number(head), do: head + sum(tail)

  def reduce([], value, _), do: value
  def reduce([head | tail], value, fun), do: reduce(tail, fun.(head, value), fun)

  def mapsum([], _fun), do: 0
  def mapsum([head | tail], fun), do: fun.(head) + mapsum(tail, fun)

  def max([]), do: nil
  def max([x]), do: x
  def max([head|[next|tail]]) when head >= next, do: max([head|tail])
  def max([head|[next|tail]]) when head < next, do: max([next|tail])

  @doc """
  Adds n to each element of a character list, but wrapping if the addition
  results in a character greater than z.
  """
  def caesar([], _n), do: []
  def caesar([head|tail], n) when n > 0, do: [charmap(head + n) | caesar(tail, n)]

  def charmap(char) when char > ?z, do: ?a + (char - ?z - 1)
  def charmap(char) when char <= ?z, do: char

  @doc "Get a list of numbers in a inclusive range"
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from+1,to)]

  def all?([], _), do: true
  def all?([head | tail], fun), do: fun.(head) and all?(tail, fun)

  def each([], _fun), do: []
  def each([head | tail], fun), do: [fun.(head) | each(tail, fun)]

  def filter([], _fun), do: []
  def filter([head | tail], fun) do
    if fun.(head), do: [head | filter(tail, fun)], else: filter(tail, fun)
  end

  def take([], _), do: []
  def take(_list, 0), do: []
  def take(list, count) when count < 0, do: take(list, length(list) + count)
  def take([head | tail], count) when count > 0, do: [head | take(tail, count-1)]

  # TODO: this can't be the best way :(
  def split([], _), do: { [], [] }
  def split(list, 0), do: { [], list }
  def split(list, count) when count < 0 and abs(count) > length(list), do: { [], list }
  def split(list, count) when count < 0, do: split(list, length(list) + count)
  def split(list, count) when count > 0 and count >= length(list), do: { list, [] }
  def split(list, count) when count > 0, do: do_split(list, count, [])

  def do_split([head|tail], count, acc) when length(acc) < count do
    do_split(tail, count, acc ++ [head])
  end
  def do_split(list, count, acc) when length(acc) == count do
    { acc, list }
  end

  def flatten([]), do: []
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten(x), do: [x]

  def is_prime(num) do
    factors = fn(num) -> span(2, trunc(:math.sqrt(num))) |> filter(&(&1 != num)) end
    factors.(num) |> each(&(rem(num, &1))) |> filter(&(&1 == 0)) |> length == 0
  end

  def primes_up_to(n) when n > 1 do
    # could also be done like this:
    #lc num inlist span(2,n), factors.(num) |> each(&(rem(num, &1))) |> filter(&(&1 == 0)) |> length == 0, do: num
    lc num inlist span(2,n), is_prime(num), do: num
  end

  def add_total_amount(orders, tax_rates) do
    lc order inlist orders do
      tax = 1 + Dict.get(tax_rates, order[:ship_to], 0.0)
      Dict.put(order, :total_amount, order[:net_amount] * tax)
    end
  end
end
