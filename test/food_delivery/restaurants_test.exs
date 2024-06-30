defmodule FoodDelivery.RestaurantsTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Restaurants

  describe "restaurants" do
    alias FoodDelivery.Restaurants.Restaurant

    import FoodDelivery.RestaurantsFixtures

    @invalid_attrs %{name: nil, address: nil, latitude: nil, longitude: nil, logo: nil}

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert Restaurants.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Restaurants.get_restaurant!(restaurant.id) == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      valid_attrs = %{name: "some name", address: "some address", latitude: 120.5, longitude: 120.5, logo: "some logo"}

      assert {:ok, %Restaurant{} = restaurant} = Restaurants.create_restaurant(valid_attrs)
      assert restaurant.name == "some name"
      assert restaurant.address == "some address"
      assert restaurant.latitude == 120.5
      assert restaurant.longitude == 120.5
      assert restaurant.logo == "some logo"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Restaurants.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", latitude: 456.7, longitude: 456.7, logo: "some updated logo"}

      assert {:ok, %Restaurant{} = restaurant} = Restaurants.update_restaurant(restaurant, update_attrs)
      assert restaurant.name == "some updated name"
      assert restaurant.address == "some updated address"
      assert restaurant.latitude == 456.7
      assert restaurant.longitude == 456.7
      assert restaurant.logo == "some updated logo"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Restaurants.update_restaurant(restaurant, @invalid_attrs)
      assert restaurant == Restaurants.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Restaurants.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Restaurants.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Restaurants.change_restaurant(restaurant)
    end
  end
end
