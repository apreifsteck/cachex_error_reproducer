defmodule CachexErrorReproducer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  import Cachex.Spec

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: CachexErrorReproducer.Worker.start_link(arg)
      # {CachexErrorReproducer.Worker, arg}
      {Cachex,
       name: :cache,
       warmers: [
         warmer(module: CachexErrorReproducer.WillBreak, state: nil)
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CachexErrorReproducer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
