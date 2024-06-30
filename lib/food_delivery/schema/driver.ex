defmodule FoodDelivery.Drivers.Driver do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "drivers" do
    field :license_plate, :string
    belongs_to :user, FoodDelivery.Accounts.User, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(driver, attrs) do
    driver
    |> cast(attrs, [:license_plate])
    |> validate_required([:license_plate])
  end
end
