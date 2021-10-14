defmodule RandomUserGenerator.RandomUser do
  alias RandomUserGenerator.Utils

  alias RandomUserGenerator.Users

  @randomization_interval 60_000

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    schedule_randomization()

    {:ok,
     %{
       max_number: generate_random_user_point(),
       timestamp: nil
     }}
  end

  @impl true
  def handle_info(:randomize, state) do
    randomize_points_for_all_users()

    schedule_randomization()

    {:noreply, state |> Map.put(:max_number, generate_random_user_point())}
  end

  @impl true
  def handle_info({task_ref, {:ok, true}}, state) do
    IO.puts("Completed randomizing all users points")
    Process.demonitor(task_ref, [:flush])

    {:noreply, state}
  end

  @impl true
  def handle_info({:DOWN, _ref, _, _, reason}, state) do
    IO.puts("Task failed with reason #{inspect(reason)}")

    {:noreply, state}
  end

  def randomize_points_for_all_users do
    Task.Supervisor.async_nolink(__MODULE__.TaskSupervisor, fn ->
      1..1_000_000
      |> Stream.chunk_every(1_000)
      |> Task.async_stream(
        fn chunk ->
          chunk
          |> Enum.at(0)
          |> Users.update_all_with_random_points(chunk |> Enum.at(-1))
        end,
        max_concurrency: 10
      )
      |> Enum.reduce(fn _, _acc -> {:ok, true} end)
    end)
  end

  defp generate_random_user_point(), do: Utils.generate_random_number(100)
  defp get_timestamp(), do: Utils.get_timestamp()

  defp schedule_randomization(interval \\ @randomization_interval),
    do: Process.send_after(self(), :randomize, interval)
end
