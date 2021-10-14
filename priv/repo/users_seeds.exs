defmodule RandomUserGenerator.UsersSeeds do
  alias RandomUserGenerator.Repo
  alias RandomUserGenerator.Identity.User

  @seed_users_total 1_000_000
  @chunk_rate 500

  def generate_seeds() do
    1..@seed_users_total
    |> Stream.chunk_every(@chunk_rate)
    |> Task.async_stream(fn chunk ->
      Repo.insert_all(User,
       chunk
        |> Enum.map(
          fn _ -> [points: 0]
        end)
      )
      end)
    |> Stream.run
  end
end


RandomUserGenerator.UsersSeeds.generate_seeds()
