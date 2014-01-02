defmodule Tick do
  @name  :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    the_server = :global.whereis_name(@name)
    IO.puts "the server is #{inspect the_server}"
    the_server <- { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        updated_clients = clients ++ [pid]

        # update previous last client with new next, and give the
        # head of list as the next client to the newly registered
        if length(clients) > 0 do
          List.last(clients) <- { :new_next, pid }
          pid <- { :new_next, Enum.first(clients) }
        end

        # monitor this new client, so if it dies we can update our list
        Process.monitor pid

        # if we have two clients now, send the initial tick to start things off
        if length(updated_clients) == 2 do
          pid <- { :tick }
        end

        generator updated_clients

      { :DOWN, _, _, client, _ } ->
        IO.puts "Tick server got down message for client #{inspect client}, removing it."

        # one of our clients died, update the appropriate clients
        # Find the dead client in the list
        # Remove it from out list
        # Notify the client that was before it, of a new next client
        dead_client_index = Enum.find_index(clients, fn(x) -> x == client end)
        client_to_update = Enum.at(clients, dead_client_index-1, List.last(clients))
        new_next = Enum.at(clients, dead_client_index+1, Enum.first(clients))
        client_to_update <- { :new_next, new_next }

        generator List.delete(clients, client)
    end
  end
end

defmodule Client do
  @interval 2000   # 2 seconds

  def start do
    pid = spawn(__MODULE__, :receiver, [nil, false])
    Tick.register(pid)
  end

  def receiver(next_client, active) do
    receive do
      { :tick } ->
        IO.puts "tick in #{Node.self}"
        receiver(next_client, true)
      { :new_next, client } ->
        receiver(client, active)
    after
      @interval ->
        if active, do: next_client <- { :tick }
        receiver(next_client, false)
    end
  end
end
