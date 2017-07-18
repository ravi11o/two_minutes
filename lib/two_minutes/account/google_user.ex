defmodule TwoMinutes.Account.GoogleUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias TwoMinutes.Account.GoogleUser

  schema "account_google_user" do
    field :name, :string
    field :email, :string
    field :avatar, :string

    timestamps()
  end

  def changeset(%GoogleUser{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :avatar])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end
end