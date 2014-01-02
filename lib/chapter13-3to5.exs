import :timer, only: [ sleep: 1 ]

defmodule Chapter13_Exercise3to5 do
  def send_message(parent) do
    parent <- "hi from your child"
    IO.puts "Sent message from child"
    #exit(1)
    raise "I'm an exceptional child!"
  end

  def run do
    #spawn_link(Chapter13_Exercise3to5, :send_message, [self])
    Process.spawn_monitor(Chapter13_Exercise3to5, :send_message, [self])

    IO.puts "taking a quick nap..."
    sleep 500
    IO.puts "I'm awake again"

    handle_message
  end

  def handle_message do
    receive do
      {:DOWN, _, _, _, _} ->
        IO.puts "child is down"
      {:EXIT, _, _} ->
        IO.puts "child exited"
      msg ->
        IO.puts msg
        handle_message
    end
  end
end

Chapter13_Exercise3to5.run
