defmodule RandomUserGeneratorWeb.UsersControllerTest do
  use RandomUserGeneratorWeb.ConnCase
  alias RandomUserGenerator.Generators.RandomUser

  test "GET /", %{conn: conn} do
    RandomUser.reset_state()
    conn = get(conn, "/")

    assert conn.status == 200
    assert conn.resp_body |> Jason.decode!() == %{"timestamp" => nil, "users" => []}
  end
end
