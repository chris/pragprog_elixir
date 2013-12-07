defmodule Chapter7Test do
  use ExUnit.Case
  import Chapter7.Lists


  test "ListsAndRecursion-0" do
    assert sum([1,2,-3,4,5]) == 9
    assert sum([]) == 0
    assert sum([5]) == 5
    assert_raise FunctionClauseError, fn ->
      sum [3,"bad"]
    end
  end

  test "ListsAndRecursion-1" do
    assert mapsum([1,2,3], &(&1 * &1)) == 14
  end

  test "ListsAndRecursion-2" do
    assert max([3,9,-4,14,1]) == 14
    assert max([73,9,-4,14,1]) == 73
    assert max([3,9,-4,14,100]) == 100
    assert max([7]) == 7
    assert max([]) == nil
  end

  test "ListsAndRecursion-3" do
    assert caesar('ryvkve', 13) == 'elixir'
  end
end
