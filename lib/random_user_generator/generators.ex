defmodule RandomUserGenerator.Generators do
  alias __MODULE__.RandomUser

  @moduledoc """
    The Generators Context.
  """

  def get_random_users() do
    RandomUser.get_random_users()
  end
end
