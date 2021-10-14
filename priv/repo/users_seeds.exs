defmodule RandomUserGenerator.UsersSeeds do
  alias RandomUserGenerator.Repo
  alias RandomUserGenerator.Users.User

  @seed_users_total 1_000_000
  @chunk_rate 1_000

  def generate_seeds() do
    1..@seed_users_total
    |> Enum.map(
          fn _ -> [points: 0]
        end)
    |> Stream.chunk_every(@chunk_rate)
    |> Task.async_stream(fn chunk -> Repo.insert_all(User, chunk) end, max_concurrency: 10)
    |> Stream.run
  end
end


RandomUserGenerator.UsersSeeds.generate_seeds()
