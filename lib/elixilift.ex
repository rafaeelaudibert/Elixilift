defmodule Elixilift do
  use Application

  def start(_type, _args) do
    children = [
      {Elixilift.LiftSupervisor, lift_count: 12},
      {Elixilift.Cron, name: Elixilift.Cron}
    ]

    opts = [strategy: :one_for_one, name: Elixilift.Application]
    Supervisor.start_link(children, opts)
  end
end
