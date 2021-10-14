defmodule RandomUserGenerator.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RandomUserGenerator.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        points: 42
      })
      |> RandomUserGenerator.Users.create_user()

    user
  end
end
