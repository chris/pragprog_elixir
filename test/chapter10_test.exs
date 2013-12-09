defmodule Chapter10Test do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Chapter10

  test "StringsAndBinaries-7" do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    assert read_orders("test/sales_data.csv") |> add_total_amount(tax_rates) == [
        Chapter10.Order[id: 123, ship_to: :NC, net_amount: 100.0, total_amount: 107.5],
        Chapter10.Order[id: 124, ship_to: :OK, net_amount: 35.5,  total_amount: 35.5],
        Chapter10.Order[id: 125, ship_to: :TX, net_amount: 24.0,  total_amount: 25.92],
        Chapter10.Order[id: 126, ship_to: :TX, net_amount: 44.8,  total_amount: 48.384],
        Chapter10.Order[id: 127, ship_to: :NC, net_amount: 25.0,  total_amount: 26.875],
        Chapter10.Order[id: 128, ship_to: :MA, net_amount: 10.0,  total_amount: 10.0],
        Chapter10.Order[id: 129, ship_to: :CA, net_amount: 102.0, total_amount: 102.0],
        Chapter10.Order[id: 120, ship_to: :NC, net_amount: 50.0,  total_amount: 53.75]
    ]
  end
end
