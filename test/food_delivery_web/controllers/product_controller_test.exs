defmodule FoodDeliveryWeb.ProductControllerTest do
  use FoodDeliveryWeb.ConnCase

  import FoodDelivery.ProductsFixtures

  alias FoodDelivery.Products.Product

  @create_attrs %{
    name: "some name",
    description: "some description",
    image: "some image",
    price: 42,
    stock: 42,
    is_available: true,
    is_favorite: true
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    image: "some updated image",
    price: 43,
    stock: 43,
    is_available: false,
    is_favorite: false
  }
  @invalid_attrs %{name: nil, description: nil, image: nil, price: nil, stock: nil, is_available: nil, is_favorite: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/products")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/products", product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/products/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "image" => "some image",
               "is_available" => true,
               "is_favorite" => true,
               "name" => "some name",
               "price" => 42,
               "stock" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/products", product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put(conn, ~p"/api/v1/products/#{product}", product: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/products/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "image" => "some updated image",
               "is_available" => false,
               "is_favorite" => false,
               "name" => "some updated name",
               "price" => 43,
               "stock" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, ~p"/api/v1/products/#{product}", product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete(conn, ~p"/api/v1/products/#{product}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/products/#{product}")
      end
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
