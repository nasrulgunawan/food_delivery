defmodule FoodDelivery.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodDelivery.Restaurants` context.
  """

  @doc """
  Generate a restaurant.
  """
  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        address: "some address",
        latitude: 120.5,
        longitude: 120.5,
        name: "some name",
        logo: "some logo"
      })
      |> FoodDelivery.Restaurants.create_restaurant()

    restaurant
  end
end
