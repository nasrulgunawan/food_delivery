defmodule FoodDeliveryWeb.ProductJSON do
  alias FoodDelivery.Products.Product

  @doc """
  Renders a list of products.
  """
  def index(%{products: products}) do
    %{data: for(product <- products, do: data(product))}
  end

  @doc """
  Renders a single product.
  """
  def show(%{product: product}) do
    %{data: data(product)}
  end

  defp data(%Product{} = product) do
    %{
      id: product.id,
      name: product.name,
      image: product.image,
      description: product.description,
      price: product.price,
      stock: product.stock,
      is_available: product.is_available,
      is_favorite: product.is_favorite
    }
  end
end
