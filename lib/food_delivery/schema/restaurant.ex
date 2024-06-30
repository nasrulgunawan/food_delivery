defmodule FoodDelivery.Restaurants.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "restaurants" do
    field :name, :string
    field :address, :string
    field :latitude, :float
    field :longitude, :float
    field :logo, :string
    # field :slug, :string
    belongs_to :user, FoodDelivery.Accounts.User, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :address, :latitude, :longitude, :logo])
    |> validate_required([:name, :address, :latitude, :longitude, :logo])
  end
end
