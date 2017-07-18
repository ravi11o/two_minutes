defmodule TwoMinutes.Account do
  @moduledoc """
  The boundary for the Account system.
  """

  import Ecto.Query, warn: false
  alias TwoMinutes.Repo

  alias TwoMinutes.Account.User
  alias TwoMinutes.Account.GoogleUser
  alias TwoMinutes.Account.FacebookUser

  ############################ User Queries ###############################

  def list_users do
    Repo.all(User)
  end

  
  def get_user!(id), do: Repo.get!(User, id)

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def create_user(attrs \\ %{}) do
    if attrs["avatar"] do
      uploaded = upload_image(attrs)
    end
    new_attrs = Map.put(attrs, "avatar", uploaded)

    %User{}
    |> User.changeset(new_attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    if attrs["avatar"] do
      uploaded = upload_image(attrs)
    end
    new_attrs = Map.put(attrs, "avatar", uploaded)

    user
    |> User.changeset(new_attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  defp upload_image(%{"avatar" => avatar}) do
    case Cloudex.upload(avatar.path) do
      [ok: image] -> image.url
      true -> nil
    end 
  end

  ########## Google User Queries ###################
  def get_user_from_google(email) do
    Repo.get_by(GoogleUser, email: email)
  end

  def create_google_user(user_params) do
    %GoogleUser{}
    |> GoogleUser.changeset(user_params)
    |> Repo.insert()
  end


  ########### Facebook User Queries ###############

  def get_user_from_facebook(uid) do
    Repo.get_by(FacebookUser, uid: uid)
  end

  def create_facebook_user(user_params) do
    %FacebookUser{}
    |> FacebookUser.changeset(user_params)
    |> Repo.insert()
  end
end
