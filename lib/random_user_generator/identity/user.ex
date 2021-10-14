defmodule RandomUserGenerator.Identity.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: non_neg_integer,
          points: integer()
        }

  schema "users" do
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
  end
end
