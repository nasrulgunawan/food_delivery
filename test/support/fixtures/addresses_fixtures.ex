defmodule FoodDelivery.AddressesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodDelivery.Addresses` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        detail: "some detail",
        latitude: 120.5,
        longitude: 120.5,
        name: "some name"
      })
      |> FoodDelivery.Addresses.create_address()

    address
  end
end
