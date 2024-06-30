defmodule FoodDelivery.AddressesTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Addresses

  describe "addresses" do
    alias FoodDelivery.Addresses.Address

    import FoodDelivery.AddressesFixtures

    @invalid_attrs %{name: nil, detail: nil, latitude: nil, longitude: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Addresses.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Addresses.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{name: "some name", detail: "some detail", latitude: 120.5, longitude: 120.5}

      assert {:ok, %Address{} = address} = Addresses.create_address(valid_attrs)
      assert address.name == "some name"
      assert address.detail == "some detail"
      assert address.latitude == 120.5
      assert address.longitude == 120.5
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Addresses.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{name: "some updated name", detail: "some updated detail", latitude: 456.7, longitude: 456.7}

      assert {:ok, %Address{} = address} = Addresses.update_address(address, update_attrs)
      assert address.name == "some updated name"
      assert address.detail == "some updated detail"
      assert address.latitude == 456.7
      assert address.longitude == 456.7
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Addresses.update_address(address, @invalid_attrs)
      assert address == Addresses.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Addresses.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Addresses.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Addresses.change_address(address)
    end
  end
end
