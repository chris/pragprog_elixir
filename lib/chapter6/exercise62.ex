defmodule Chapter6.Exercise62 do
  def sum(n), do: sum(n, 0)

  defp sum(1, acc), do: acc + 1
  defp sum(n, acc), do: sum(n-1, acc+n)

  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y, rem(x,y))
end
