defmodule TokenEchoer do
  def echo do
    receive do
      {sender, token} ->
        sender <- token
    end
  end
end

pid1 = spawn(TokenEchoer, :echo, [])
pid2 = spawn(TokenEchoer, :echo, [])

pid1 <- {self, "happy happy"}
pid2 <- {self, "joy joy"}

receive do
  token -> IO.puts token
end
receive do
  token -> IO.puts token
end
