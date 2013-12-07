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
  def caesar([], n), do: []
  def caesar([head|tail], n) when n > 0, do: [charmap(head + n) | caesar(tail, n)]

  def charmap(char) when char > ?z, do: ?a + (char - ?z - 1)
  def charmap(char) when char <= ?z, do: char
end
