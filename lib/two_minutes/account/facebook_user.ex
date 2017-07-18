defmodule TwoMinutes.Account.FacebookUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias TwoMinutes.Account.FacebookUser

  schema "account_facebook_user" do
    field :name, :string
    field :uid, :string
    field :avatar, :string

    timestamps()
  end

  def changeset(%FacebookUser{} = user, attrs) do
    user
    |> cast(attrs, [:name, :uid, :avatar])
    |> validate_required([:name, :uid])
    |> unique_constraint(:uid)
  end
end