defmodule FoodDeliveryWeb.UserSessionJSON do
  alias FoodDelivery.Accounts.User

  @doc """
  Renders a single user.
  """
  def show(%{user: user, token: token}) do
    %{data: data(user, token)}
  end

  def error(%{error: error}), do: %{error: error}

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      photo: user.photo,
      token: token
    }
  end
end
