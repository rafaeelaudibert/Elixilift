defmodule Elixilift.Lift do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{level: 0}, opts)
  end

  def init(state) do
    {:ok, state}
  end

  def move_to(level), do: GenServer.call(Elixilift.Lift, {:move_to, level})

  def handle_call({:move_to, level}, _from, state) do
    IO.inspect(["Current state", state])

    # Reschedule once more
    {:reply, level, %{level: level}}
  end
end
