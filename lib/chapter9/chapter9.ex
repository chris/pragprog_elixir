defmodule Chapter9 do
  def only_printable?([]), do: false
  # Interestingly, doing "? " actually works, but it's hard to tell, so used 32 for space instead
  def only_printable?(list), do: Enum.all?(list, &(&1 >= 32 and &1 <= ?~))

  def anagram?(word1, word2) when word1 == word2, do: false
  def anagram?(word1, word2), do: Enum.sort(%c"#{word1}") == Enum.sort(%c"#{word2}")


  @doc """
  Calculate a simple math expression provided as a char list. You may only use the
  operators [+-*/]. For example:

      calculate('123 + 45')
      => 168
  """
  def calculate(expression) do
    do_calc = fn
      [ term1, '+', term2 ] -> number(term1) + number(term2)
      [ term1, '-', term2 ] -> number(term1) - number(term2)
      [ term1, '*', term2 ] -> number(term1) * number(term2)
      [ term1, '/', term2 ] -> number(term1) / number(term2)
    end
    do_calc.(Enum.map %w"#{expression}", &(%c"#{&1}"))
  end

  def number(str), do: _number_digits(str, 0)
  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value) when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([non_digit | _], _), do: raise "Invalid digit '#{[non_digit]}'"


  @doc "Center a list of words on the longest word in the list"
  def center([]), do: ""
  def center(list) do
    size = Enum.max_by(list, &(String.length(&1))) |> String.length
    width = fn(str) ->
      len = String.length(str)
      trunc((size - len) / 2) + len
    end

    Enum.each list, &(IO.puts String.rjust(&1, width.(&1)))
  end

  @doc "Ensure each sentence in a string is capitalized"
  def capitalize_sentences(str) do
    sentences = String.split(str, ". ")
    Enum.map(sentences, &(_capitalize_sentence(&1))) |> Enum.join(". ")
  end

  defp _capitalize_sentence(""), do: ""
  defp _capitalize_sentence(<< head :: utf8 , tail :: binary >>) when head <= ?Z, do: [ head | tail ]
  defp _capitalize_sentence(<< head :: utf8 , tail :: binary >>) when head > ?Z, do: [ head - 32 | tail ]

  def read_sales_data(file_path) do
    file = File.open!(file_path)
    headers = IO.read(file, :line)
              |> String.strip
              |> String.split(",")
              |> Enum.map(&binary_to_atom/1)

    parse_data = fn [ id, ship_to, amount ] ->
      [ binary_to_integer(id), binary_to_atom(String.slice(ship_to, 1..-1)), binary_to_float(amount) ]
    end

    IO.stream(file, :line)
    |> Stream.map(&(String.strip(&1)))
    |> Stream.map(&(String.split(&1, ",")))
    |> Enum.to_list
    |> Enum.map(&(parse_data.(&1)))
    |> Enum.map(&(Enum.zip(headers, &1)))
  end
end
