defmodule TwoMinutes.Repo.Migrations.AlterColumnUid do
  use Ecto.Migration

  def change do
    alter table(:account_facebook_user) do
      modify :uid, :varchar
    end
  end
end
