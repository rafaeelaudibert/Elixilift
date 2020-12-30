defmodule Elixilift.LiftSupervisor do
  def start_link(opts) do
    lift_count = Keyword.fetch!(opts, :lift_count)

    children =
      Enum.map(1..lift_count, fn idx ->
        Supervisor.child_spec(Elixilift.Lift, id: {Elixilift.Lift, idx})
      end)

    opts = [strategy: :one_for_one, name: Elixilift.LiftSupervisor]
    Supervisor.start_link(children, opts)
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      name: __MODULE__,
      type: :supervisor
    }
  end
end
