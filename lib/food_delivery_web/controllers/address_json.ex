defmodule FoodDeliveryWeb.AddressJSON do
  alias FoodDelivery.Addresses.Address

  @doc """
  Renders a list of addresses.
  """
  def index(%{addresses: addresses}) do
    %{data: for(address <- addresses, do: data(address))}
  end

  @doc """
  Renders a single address.
  """
  def show(%{address: address}) do
    %{data: data(address)}
  end

  defp data(%Address{} = address) do
    %{
      id: address.id,
      name: address.name,
      detail: address.detail,
      latitude: address.latitude,
      longitude: address.longitude
    }
  end
end
