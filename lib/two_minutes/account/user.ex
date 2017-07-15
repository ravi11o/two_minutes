defmodule TwoMinutes.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TwoMinutes.Account.User


  schema "account_users" do
    field :avatar, :string
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :provider, {:array, :string}
    field :verified, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :hashed_password, :password, :verified, :is_admin, :avatar, :provider])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(pass))

      _ -> changeset
    end
  end
end
