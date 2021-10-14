defmodule RandomUserGenerator.Repo do
  use Ecto.Repo,
    otp_app: :random_user_generator,
    adapter: Ecto.Adapters.Postgres
end
