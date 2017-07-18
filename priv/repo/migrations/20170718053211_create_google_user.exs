defmodule TwoMinutes.Repo.Migrations.CreateGoogleUser do
  use Ecto.Migration

  def change do
    create table(:account_google_user) do
      add :uid, :integer
      add :name, :string
      add :avatar, :string

      timestamps()
    end

    create unique_index(:account_google_user, [:uid])
  end
end
