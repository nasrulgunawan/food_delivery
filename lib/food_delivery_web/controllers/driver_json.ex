defmodule FoodDeliveryWeb.DriverJSON do
  alias FoodDelivery.Drivers.Driver

  @doc """
  Renders a list of drivers.
  """
  def index(%{drivers: drivers}) do
    %{data: for(driver <- drivers, do: data(driver))}
  end

  @doc """
  Renders a single driver.
  """
  def show(%{driver: driver}) do
    %{data: data(driver)}
  end

  defp data(%Driver{user: user} = driver) do
    %{
      id: driver.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      photo: user.photo,
      license_plate: driver.license_plate
    }
  end
end
