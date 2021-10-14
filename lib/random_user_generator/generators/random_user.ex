defmodule RandomUserGenerator.RandomUser do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    {:ok,
     %{
       max_number: 0,
       timestamp: nil
     }}
  end
end
