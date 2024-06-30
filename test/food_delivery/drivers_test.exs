defmodule FoodDelivery.DriversTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Drivers

  describe "drivers" do
    alias FoodDelivery.Drivers.Driver

    import FoodDelivery.DriversFixtures

    @invalid_attrs %{license_plate: nil}

    test "list_drivers/0 returns all drivers" do
      driver = driver_fixture()
      assert Drivers.list_drivers() == [driver]
    end

    test "get_driver!/1 returns the driver with given id" do
      driver = driver_fixture()
      assert Drivers.get_driver!(driver.id) == driver
    end

    test "create_driver/1 with valid data creates a driver" do
      valid_attrs = %{license_plate: "some license_plate"}

      assert {:ok, %Driver{} = driver} = Drivers.create_driver(valid_attrs)
      assert driver.license_plate == "some license_plate"
    end

    test "create_driver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver(@invalid_attrs)
    end

    test "update_driver/2 with valid data updates the driver" do
      driver = driver_fixture()
      update_attrs = %{license_plate: "some updated license_plate"}

      assert {:ok, %Driver{} = driver} = Drivers.update_driver(driver, update_attrs)
      assert driver.license_plate == "some updated license_plate"
    end

    test "update_driver/2 with invalid data returns error changeset" do
      driver = driver_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver(driver, @invalid_attrs)
      assert driver == Drivers.get_driver!(driver.id)
    end

    test "delete_driver/1 deletes the driver" do
      driver = driver_fixture()
      assert {:ok, %Driver{}} = Drivers.delete_driver(driver)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver!(driver.id) end
    end

    test "change_driver/1 returns a driver changeset" do
      driver = driver_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver(driver)
    end
  end
end
