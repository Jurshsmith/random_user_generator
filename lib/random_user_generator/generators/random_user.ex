defmodule RandomUserGenerator.RandomUser do
  alias RandomUserGenerator.Utils

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    {:ok,
     %{
       max_number: generate_random_user_point(),
       timestamp: nil
     }}
  end

  defp generate_random_user_point(), do: Utils.generate_random_number(100)
  defp get_timestamp(), do: Utils.get_timestamp()
end
