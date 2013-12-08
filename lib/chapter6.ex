defmodule Chapter6 do
  defmodule Chop do
    def guess(answer, low..high) do
      a_guess = div(high+low, 2)
      IO.puts "Is it #{a_guess}"
      _guess(answer, low..high, a_guess)
    end

    defp _guess(answer, _low.._high, a_guess) when answer == a_guess, do: IO.puts answer

    defp _guess(answer, low.._high, a_guess) when a_guess > answer do
      guess(answer, low..(a_guess - 1))
    end

    defp _guess(answer, _low..high, a_guess) when a_guess < answer do
      guess(answer, (a_guess + 1)..high)
    end
  end

  defmodule Exercise62 do
    def sum(n), do: _sum(n, 0)

    defp _sum(1, acc), do: acc + 1
    defp _sum(n, acc), do: _sum(n-1, acc+n)

    def gcd(x,0), do: x
    def gcd(x,y), do: gcd(y, rem(x,y))
  end

  defmodule Times do
    def double(n), do: n * 2
    def triple(n), do: n * 3
    def quadruple(n), do: double(double(n))
  end
end
