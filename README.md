# RandomUserGenerator

Base System Dependencies: `Erlang`, `Elixir`, `Docker`

**Developement Infrastructure Setup**

- Clone the repo
- From root directory
- `docker-compose up`

**To start your Phoenix server**

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup` or reset with `mix ecto.reset`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

**Things that can be improved**

- More optimized strategy: create a new table and stream bulk inserts, truncate old table, and copy all from the new table to the old table
- More unit test coverage
- More Doc tests
