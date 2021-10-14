defmodule RandomUserGenerator.GeneratorsTest do
  use ExUnit.Case
  use RandomUserGenerator.DataCase

  alias RandomUserGenerator.Generators
  alias RandomUserGenerator.Generators.RandomUser

  test "generates empty random user if no user" do
    RandomUser.reset_state()
    assert Generators.get_random_users() == %{timestamp: nil, users: []}
  end

  test "appends timestamp of last request correctly" do
    Generators.get_random_users()
    %{timestamp: timestamp} = Generators.get_random_users()
    assert timestamp |> String.contains?("UTC")
  end
end
