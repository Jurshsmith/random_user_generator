defmodule RandomUserGenerator.Utils do
  @spec generate_random_number(non_neg_integer) :: non_neg_integer
  def generate_random_number(max_count) do
    :rand.uniform(max_count + 1) - 1
  end

  @spec get_timestamp :: binary
  def get_timestamp(), do: DateTime.utc_now() |> Calendar.strftime("%Y-%m-%d %H:%M:%S UTC")
end
