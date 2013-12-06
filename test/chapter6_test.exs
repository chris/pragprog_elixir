defmodule Chapter6Test do
  use ExUnit.Case
  import ExUnit.CaptureIO


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

  test "chapter 6.4" do
    import Chapter6.Chop

    assert capture_io(fn -> guess(273, 1..1000) end) == """
      Is it 500
      Is it 250
      Is it 375
      Is it 312
      Is it 281
      Is it 265
      Is it 273
      273
      """
  end

  # Chapter 6.7 stuff
  test "Convert a float to a string with 2 decimal digits. (Erlang)" do
    assert capture_io(fn -> :io.format("~.2f~n", [123.4567]) end) |> String.strip == "123.46"
  end

  test "Get the value of an operating system environment variable. (Elixir)" do
    assert System.get_env("HOME") == "/Users/chris"
  end

  test "Return the extension component of a file name (so return .exs if given \"dave/test.exs\" (Elixir)" do
    assert Path.extname("/Users/chris/book.ex") == ".ex"
    assert Path.extname("/Users/chris/book") == ""
  end

  test "Return the current working directory of the process. (Elixir)" do
    assert System.cwd != nil
  end

  test "Convert a string containing JSON into Elixir data structures. (Just find, don't install)" do
    # "http://expm.co/json"
  end

  test "Execute an command in your operating system's shell" do
    assert System.cmd("echo 'Elixir is cool'") |> String.strip == "Elixir is cool"
  end
end
