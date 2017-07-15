defmodule TwoMinutes.Repo.Migrations.CreateTwoMinutes.Account.User do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :name, :string
      add :email, :string
      add :hashed_password, :string
      add :verified, :boolean, default: false, null: false
      add :is_admin, :boolean, default: false, null: false
      add :avatar, :string
      add :provider, {:array, :string}

      timestamps()
    end

    create unique_index(:account_users, [:email])
  end
end
