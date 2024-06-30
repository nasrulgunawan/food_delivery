defmodule FoodDelivery.ProductsTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Products

  describe "products" do
    alias FoodDelivery.Products.Product

    import FoodDelivery.ProductsFixtures

    @invalid_attrs %{name: nil, description: nil, image: nil, price: nil, stock: nil, is_available: nil, is_favorite: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", description: "some description", image: "some image", price: 42, stock: 42, is_available: true, is_favorite: true}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.image == "some image"
      assert product.price == 42
      assert product.stock == 42
      assert product.is_available == true
      assert product.is_favorite == true
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", image: "some updated image", price: 43, stock: 43, is_available: false, is_favorite: false}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.image == "some updated image"
      assert product.price == 43
      assert product.stock == 43
      assert product.is_available == false
      assert product.is_favorite == false
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
