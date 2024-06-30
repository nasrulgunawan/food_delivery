defmodule FoodDelivery.Drivers do
  @moduledoc """
  The Drivers context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Changeset
  alias FoodDelivery.Repo
  alias FoodDelivery.Drivers.Driver
  alias FoodDelivery.Accounts
  alias FoodDelivery.Accounts.User
  alias FoodDelivery.Upload

  @doc """
  Returns the list of drivers.

  ## Examples

      iex> list_drivers()
      [%Driver{}, ...]

  """
  def list_drivers do
    Driver
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single driver.

  Raises `Ecto.NoResultsError` if the Driver does not exist.

  ## Examples

      iex> get_driver!(123)
      %Driver{}

      iex> get_driver!(456)
      ** (Ecto.NoResultsError)

  """
  def get_driver!(id), do: Repo.get!(Driver, id)

  @doc """
  Creates a driver.

  ## Examples

      iex> create_driver(%{field: value})
      {:ok, %Driver{}}

      iex> create_driver(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_driver(attrs \\ %{}) do
    {driver_attrs, user_attrs} = Map.split(attrs, ~w[license_plate])

    with {:ok, user} <- Accounts.register_user(user_attrs) do
      {:ok, driver} = %Driver{}
      |> Driver.changeset(attrs)
      |> Changeset.put_assoc(:user, user)
      |> Repo.insert()

      {:ok, %{driver | user: user}}
    end
  end

  @doc """
  Updates a driver.

  ## Examples

      iex> update_driver(driver, %{field: new_value})
      {:ok, %Driver{}}

      iex> update_driver(driver, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_driver(%Driver{} = driver, attrs) do
    driver
    |> Driver.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a driver.

  ## Examples

      iex> delete_driver(driver)
      {:ok, %Driver{}}

      iex> delete_driver(driver)
      {:error, %Ecto.Changeset{}}

  """
  def delete_driver(%Driver{} = driver) do
    Repo.delete(driver)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking driver changes.

  ## Examples

      iex> change_driver(driver)
      %Ecto.Changeset{data: %Driver{}}

  """
  def change_driver(%Driver{} = driver, attrs \\ %{}) do
    Driver.changeset(driver, attrs)
  end
end
