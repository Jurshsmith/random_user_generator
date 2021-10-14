defmodule RandomUserGenerator.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias RandomUserGenerator.Repo

  alias RandomUserGenerator.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @spec update_all_with_random_points(integer, integer) :: any
  def update_all_with_random_points(min, max) when is_integer(min + max) do
    from(user in User,
      where: user.id >= ^min and user.id <= ^max,
      update: [set: [points: fragment("floor(random() * (100 + 1))")]]
    )
    |> Repo.update_all([])
  end

  @spec get_users_based_on_points(integer(), integer() | none()) :: list(any)
  def get_users_based_on_points(points, limit \\ 2) do
    try do
      from(user in User,
        where: user.points > ^points,
        select: {user.id, user.points},
        limit: ^limit
      )
      |> Repo.all()
      |> Enum.map(fn {id, user_points} -> %{id: id, points: user_points} end)
    rescue
      e ->
        IO.inspect(e)
        []
    end
  end
end
