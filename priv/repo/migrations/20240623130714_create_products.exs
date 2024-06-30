defmodule FoodDelivery.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :image, :string
      add :description, :text
      add :price, :integer
      add :stock, :integer
      add :is_available, :boolean, default: true, null: false
      add :is_favorite, :boolean, default: false, null: false
      add :restaurant_id, references(:restaurants, type: :uuid, on_delete: :nothing)
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:products, [:restaurant_id])
    create index(:products, [:user_id])
  end
end
