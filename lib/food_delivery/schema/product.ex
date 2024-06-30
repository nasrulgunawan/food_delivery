defmodule FoodDelivery.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :description, :string
    field :image, :string
    field :price, :integer
    field :stock, :integer
    field :is_available, :boolean, default: true
    field :is_favorite, :boolean, default: false
    belongs_to :restaurant, FoodDelivery.Restaurants.Restaurant, type: :binary_id
    belongs_to :user, FoodDelivery.Accounts.User, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :image, :description, :price, :stock, :is_available, :is_favorite])
    |> validate_required([:name, :image, :description, :price, :stock, :is_available, :is_favorite])
  end
end
