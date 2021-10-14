defmodule RandomUserGenerator.IdentityFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RandomUserGenerator.Identity` context.
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
      |> RandomUserGenerator.Identity.create_user()

    user
  end
end
