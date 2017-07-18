defmodule TwoMinutes.Repo.Migrations.CreateTableFacebookUser do
  use Ecto.Migration

  def change do
    create table(:account_facebook_user) do
      add :uid, :integer
      add :name, :string
      add :avatar, :string

      timestamps()
    end
    create unique_index(:account_facebook_user, [:uid])
  end
end
