defmodule FoodDelivery.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :address, :text
      add :latitude, :float
      add :longitude, :float
      add :logo, :string
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:restaurants, [:user_id])
  end
end
