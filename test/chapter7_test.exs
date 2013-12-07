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

  test "ListsAndRecursion-4" do
    assert span(7,10) == [7,8,9,10]
    assert span(10,7) == []
  end

  test "ListsAndRecursion-5 all?" do
    assert all?([1,2,3], &(&1 == 2)) == false
    assert all?([2,6,20], &(rem(&1, 2) == 0)) == true
  end

  test "ListsAndRecursion-5 each" do
    assert each([1,2,3], &(&1 * &1)) == [1,4,9]
    assert each([], &(&1 * &1)) == []
  end

  test "ListsAndRecursion-5 filter" do
    assert filter([1, 2, 9, 24], &(rem(&1, 2) == 0)) == [2, 24]
    assert filter([0, true, false, 1, nil, "woah"], &(&1)) == [0, true, 1, "woah"]
  end

  test "ListsAndRecursion-5 split" do
    assert split([1, 2, 3], 0)  == { [], [1,2, 3] }
    assert split([1, 2, 3], -5) == { [], [1,2,3] }
    assert split([1, 2, 3], 10) == { [1,2,3], [] }
    assert split([1, 2, 3], 2)  == { [1,2], [3] }
    assert split([1, 2, 3], -1) == { [1,2], [3] }
    assert split([], 3)         == { [], [] }
  end

  test "ListsAndRecursion-5 take" do
    assert take([], 7) == []
    assert take([1, 2, 3], 0) == []
    assert take([1, 2, 3], 2) == [1,2]
    assert take([1, 2, 3], 10) == [1,2,3]
    assert take([1, 2, 3], -1) == [1,2]
  end

  test "ListsAndRecursion-6 flatten" do
    assert flatten([ 1, [ 2, 3, [4] ], 5, [[[ 6]]]]) == [1,2,3,4,5,6]
    assert flatten([ [1,2], [ 3, [4] ], 5, [[[ 6]]]]) == [1,2,3,4,5,6]
  end

  test "ListsAndRecursion-7" do
    assert primes_up_to(20) == [2,3,5,7,11,13,17,19]
    assert primes_up_to(2) == [2]
  end

  test "ListsAndRecursion-8" do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    orders = [
      [ id: 123, ship_to: :NC, net_amount: 100.00 ],
      [ id: 124, ship_to: :OK, net_amount:  35.50 ],
      [ id: 125, ship_to: :TX, net_amount:  24.00 ],
      [ id: 126, ship_to: :TX, net_amount:  44.80 ],
      [ id: 127, ship_to: :NC, net_amount:  25.00 ],
      [ id: 128, ship_to: :MA, net_amount:  10.00 ],
      [ id: 129, ship_to: :CA, net_amount: 102.00 ],
      [ id: 120, ship_to: :NC, net_amount:  50.00 ]
    ]
    orders_with_tax = [
      [ total_amount: 107.50,  id: 123, ship_to: :NC, net_amount: 100.00 ],
      [ total_amount:  35.50,  id: 124, ship_to: :OK, net_amount:  35.50 ],
      [ total_amount:  25.92,  id: 125, ship_to: :TX, net_amount:  24.00 ],
      [ total_amount:  48.384, id: 126, ship_to: :TX, net_amount:  44.80 ],
      [ total_amount: 26.875,  id: 127, ship_to: :NC, net_amount:  25.00 ],
      [ total_amount:  10.00,  id: 128, ship_to: :MA, net_amount:  10.00 ],
      [ total_amount: 102.00,  id: 129, ship_to: :CA, net_amount: 102.00 ],
      [ total_amount:  53.75,  id: 120, ship_to: :NC, net_amount:  50.00 ]
    ]

    assert add_total_amount(orders, tax_rates) == orders_with_tax
  end

end
