defmodule FoodDelivery.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :detail, :text
      add :latitude, :float
      add :longitude, :float
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:addresses, [:user_id])
  end
end
