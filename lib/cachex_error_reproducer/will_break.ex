defmodule CachexErrorReproducer.WillBreak do
  use Cachex.Warmer
  
  def interval,
    do: :timer.seconds(30)

  def execute(_) do
    dbg(self())
    send(self(), :wreck_it)
    {:ok, [:foo]}
  end
end
