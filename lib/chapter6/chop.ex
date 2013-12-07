defmodule Chapter6.Chop do
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
