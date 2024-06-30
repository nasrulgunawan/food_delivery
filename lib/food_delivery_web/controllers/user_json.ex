defmodule FoodDeliveryWeb.UserJSON do
  alias FoodDelivery.Accounts.User

  @doc """
  Renders a single user.
  """
  def show(%{user: user, token: token}) do
    %{data: data(user, token)}
  end

  defp data(%User{} = user, token) do
    user = %{
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      photo: user.photo,
    }

    if token, do: Map.put(user, :token, token)

    user
  end
end
