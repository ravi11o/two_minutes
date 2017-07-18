defmodule TwoMinutes.Repo.Migrations.AlterTableGoogleUser do
  use Ecto.Migration

  def change do
    alter table(:account_google_user) do
      add :email, :string
      remove :uid
    end

    create unique_index(:account_google_user, [:email])
  end
end
