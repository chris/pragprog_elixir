defmodule Chapter6Test do
  use ExUnit.Case


  test "chapter 6.1" do
    import Chapter6.Times

    assert triple(3) == 9
    assert quadruple(4) == 16
  end

  test "chapter 6.2" do
    import Chapter6.Exercise62

    assert sum(10) == 55

    assert gcd(10,0) == 10
    assert gcd(0,10) == 10
    assert gcd(25,35) == 5
    assert gcd(17,42) == 1
    assert gcd(75*7,75*23) == 75
  end
end
