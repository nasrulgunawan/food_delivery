defmodule FoodDeliveryWeb.DriverControllerTest do
  use FoodDeliveryWeb.ConnCase

  import FoodDelivery.DriversFixtures

  alias FoodDelivery.Drivers.Driver

  @create_attrs %{
    license_plate: "some license_plate"
  }
  @update_attrs %{
    license_plate: "some updated license_plate"
  }
  @invalid_attrs %{license_plate: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all drivers", %{conn: conn} do
      conn = get(conn, ~p"/api/v1/drivers")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create driver" do
    test "renders driver when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/drivers", driver: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/v1/drivers/#{id}")

      assert %{
               "id" => ^id,
               "license_plate" => "some license_plate"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/v1/drivers", driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update driver" do
    setup [:create_driver]

    test "renders driver when data is valid", %{conn: conn, driver: %Driver{id: id} = driver} do
      conn = put(conn, ~p"/api/v1/drivers/#{driver}", driver: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/v1/drivers/#{id}")

      assert %{
               "id" => ^id,
               "license_plate" => "some updated license_plate"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, driver: driver} do
      conn = put(conn, ~p"/api/v1/drivers/#{driver}", driver: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete driver" do
    setup [:create_driver]

    test "deletes chosen driver", %{conn: conn, driver: driver} do
      conn = delete(conn, ~p"/api/v1/drivers/#{driver}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/v1/drivers/#{driver}")
      end
    end
  end

  defp create_driver(_) do
    driver = driver_fixture()
    %{driver: driver}
  end
end
