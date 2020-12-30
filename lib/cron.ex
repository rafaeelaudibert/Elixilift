defmodule Elixilift.Cron do
  use GenServer

  @timeout 1000

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(state) do
    # Schedule work to be performed at some point
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Reschedule once more
    schedule_work()

    # Do the work you desire here
    # IO.inspect(["Received back", Elixilift.Lift.move_to(:rand.uniform(15))])

    {:noreply, state}
  end

  defp schedule_work() do
    # In 2 hours
    Process.send_after(self(), :work, @timeout)
  end
end
