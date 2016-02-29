defmodule Surrogate do
  use Application

  alias Plug.Adapters.Cowboy

  def start(_, _) do
    import Supervisor.Spec

    children = [
      Cowboy.child_spec(:http, Surrogate.Server, [], [dispatch: dispatch]),
      worker(Surrogate.PubSub, [])
    ]

    opts = [strategy: :one_for_one, name: Surrogate.Supervisor]

    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [{:_, [{"/ws", Surrogate.Socket, []},
           {:_, Cowboy.Handler, {Surrogate.Server, []}}]}]
  end
end
