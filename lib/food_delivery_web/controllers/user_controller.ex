defmodule FoodDeliveryWeb.UserController do
  use FoodDeliveryWeb, :controller

  alias FoodDelivery.Accounts
  alias FoodDelivery.Accounts.User

  action_fallback FoodDeliveryWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Accounts.register_user(params) do
      token = Accounts.create_user_api_token(user)

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/v1/users/#{user}")
      |> render(:show, user: user, token: token)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user, token: nil)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end
end
