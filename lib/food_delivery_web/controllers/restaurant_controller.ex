defmodule FoodDeliveryWeb.RestaurantController do
  use FoodDeliveryWeb, :controller

  alias FoodDelivery.Restaurants
  alias FoodDelivery.Restaurants.Restaurant
  alias FoodDelivery.Upload

  action_fallback FoodDeliveryWeb.FallbackController

  def index(conn, _params) do
    restaurants = Restaurants.list_restaurants()
    render(conn, :index, restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => params}) do

    with {:ok, %Restaurant{} = restaurant} <- Restaurants.create_restaurant(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/restaurants/#{restaurant}")
      |> render(:show, restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant!(id)
    render(conn, :show, restaurant: restaurant)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, %Restaurant{} = restaurant} <- Restaurants.update_restaurant(restaurant, restaurant_params) do
      render(conn, :show, restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, %Restaurant{}} <- Restaurants.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end
end
