defmodule FoodDelivery.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodDelivery.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image: "some image",
        is_available: true,
        is_favorite: true,
        name: "some name",
        price: 42,
        stock: 42
      })
      |> FoodDelivery.Products.create_product()

    product
  end
end
