defmodule Chapter6.Exercise62 do
  def sum(n), do: _sum(n, 0)

  defp _sum(1, acc), do: acc + 1
  defp _sum(n, acc), do: _sum(n-1, acc+n)

  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y, rem(x,y))
end
