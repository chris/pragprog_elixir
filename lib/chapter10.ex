defmodule Chapter10 do
  defrecord Order, id: nil, ship_to: nil, net_amount: nil, total_amount: nil

  @doc "Reads orders from a CSV and returns a list of Order records."
  def read_orders(file_path) do
    file = File.open!(file_path)
    headers = IO.read(file, :line)
              |> String.strip
              |> String.split(",")
              |> Enum.map(&binary_to_atom/1)

    parse_data = fn [ id, ship_to, amount ] ->
      Order.new id: binary_to_integer(id),
                ship_to: binary_to_atom(String.slice(ship_to, 1..-1)),
                net_amount: binary_to_float(amount)
    end

    IO.stream(file, :line)
    |> Stream.map(&(String.strip(&1)))
    |> Stream.map(&(String.split(&1, ",")))
    |> Enum.to_list
    |> Enum.map(&(parse_data.(&1)))
  end

  def add_total_amount(orders, tax_rates) do
    # lc order inlist orders do
    #   tax = 1 + Dict.get(tax_rates, order.ship_to, 0.0)
    #   order.total_amount order.net_amount * tax
    # end

    Enum.map orders, fn(order) ->
      tax = 1 + Dict.get(tax_rates, order.ship_to, 0.0)
      order.total_amount order.net_amount * tax
    end
  end

end
