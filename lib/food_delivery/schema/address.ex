defmodule FoodDelivery.Addresses.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "addresses" do
    field :name, :string
    field :detail, :string
    field :latitude, :float
    field :longitude, :float
    belongs_to :user, FoodDelivery.Accounts.User, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :detail, :latitude, :longitude])
    |> validate_required([:name, :detail, :latitude, :longitude])
  end
end
