defmodule FoodDeliveryWeb.AddressControllerTest do
  use FoodDeliveryWeb.ConnCase

  import FoodDelivery.AddressesFixtures

  alias FoodDelivery.Addresses.Address

  @create_attrs %{
    name: "some name",
    detail: "some detail",
    latitude: 120.5,
    longitude: 120.5
  }
  @update_attrs %{
    name: "some updated name",
    detail: "some updated detail",
    latitude: 456.7,
    longitude: 456.7
  }
  @invalid_attrs %{name: nil, detail: nil, latitude: nil, longitude: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all addresses", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/addresses")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create address" do
    test "renders address when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/addresses", address: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/addresses/#{id}")

      assert %{
               "id" => ^id,
               "detail" => "some detail",
               "latitude" => 120.5,
               "longitude" => 120.5,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/addresses", address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update address" do
    setup [:create_address]

    test "renders address when data is valid", %{conn: conn, address: %Address{id: id} = address} do
      conn = put(conn, ~p"/api/v1/addresses/#{address}", address: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/addresses/#{id}")

      assert %{
               "id" => ^id,
               "detail" => "some updated detail",
               "latitude" => 456.7,
               "longitude" => 456.7,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, address: address} do
      conn = put(conn, ~p"/api/v1/addresses/#{address}", address: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, address: address} do
      conn = delete(conn, ~p"/api/v1/addresses/#{address}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/addresses/#{address}")
      end
    end
  end

  defp create_address(_) do
    address = address_fixture()
    %{address: address}
  end
end
