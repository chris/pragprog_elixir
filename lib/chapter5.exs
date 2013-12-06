defmodule PragprogElixir.Chapter5 do
  def exercise_51 do
    list_concat = fn list1, list2 -> (list1 ++ list2) end
    IO.puts "list_concat.([1,2,3], [4,5,6]): #{inspect list_concat.([1,2,3], [4,5,6])}"

    sum = fn a,b,c -> a + b + c end
    IO.puts "sum.(1,2,3): #{sum.(1,2,3)}"

    pair_tuple_to_list = fn {a, b} -> [a,b] end
    IO.puts "pair_tuple_to_list.( { 8, 7 } ): #{inspect pair_tuple_to_list.( { 8, 7 } )}"
  end
end

PragprogElixir.Chapter5.exercise_51
