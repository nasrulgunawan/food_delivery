defmodule FoodDelivery.DriversFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodDelivery.Drivers` context.
  """

  @doc """
  Generate a driver.
  """
  def driver_fixture(attrs \\ %{}) do
    {:ok, driver} =
      attrs
      |> Enum.into(%{
        license_plate: "some license_plate"
      })
      |> FoodDelivery.Drivers.create_driver()

    driver
  end
end
