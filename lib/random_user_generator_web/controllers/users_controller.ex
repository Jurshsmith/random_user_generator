defmodule RandomUserGeneratorWeb.UsersController do
  alias RandomUserGenerator.Generators
  use RandomUserGeneratorWeb, :controller

  def get_random_users(conn, _params) do
    random_users =
      Generators.get_random_users()
      |> IO.inspect()

    conn
    |> put_status(200)
    |> json(random_users)
  end
end
