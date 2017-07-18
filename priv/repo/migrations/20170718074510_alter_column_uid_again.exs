defmodule TwoMinutes.Repo.Migrations.AlterColumnUidAgain do
  use Ecto.Migration

  def change do
    alter table(:account_facebook_user) do
      modify :uid, :string
    end
  end
end
