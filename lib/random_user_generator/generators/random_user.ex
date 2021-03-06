defmodule RandomUserGenerator.Generators.RandomUser do
  @randomization_interval 60_000
  @chunk_range 1..1_000_000
  @chunk_rate 1_000
  @max_connection_pool 10

  alias RandomUserGenerator.Users
  alias RandomUserGenerator.Utils

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
  def handle_call(:get_random_users, _from, state) do
    {:reply,
     %{
       users: Users.get_users_based_on_points(state[:max_number]),
       timestamp: state[:timestamp]
     }, state |> Map.put(:timestamp, get_timestamp())}
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

  @impl true
  def handle_cast(:reset, _state) do
    {:noreply,
     %{
       max_number: generate_random_user_point(),
       timestamp: nil
     }}
  end

  def randomize_points_for_all_users do
    Task.Supervisor.async_nolink(__MODULE__.TaskSupervisor, fn ->
      @chunk_range
      |> Stream.chunk_every(@chunk_rate)
      |> Task.async_stream(
        fn chunk ->
          chunk
          |> Enum.at(0)
          |> Users.update_all_with_random_points(chunk |> Enum.at(-1))
        end,
        max_concurrency: @max_connection_pool
      )
      |> Enum.reduce(fn _, _acc -> {:ok, true} end)
    end)
  end

  def get_random_users() do
    GenServer.call(__MODULE__, :get_random_users)
  end

  def reset_state() do
    GenServer.cast(__MODULE__, :reset)
  end

  defp generate_random_user_point(), do: Utils.generate_random_number(100)
  defp get_timestamp(), do: Utils.get_timestamp()

  defp schedule_randomization(delay \\ @randomization_interval),
    do: Process.send_after(self(), :randomize, delay)
end
