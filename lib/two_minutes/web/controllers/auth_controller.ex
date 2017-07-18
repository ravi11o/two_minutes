defmodule TwoMinutes.Web.AuthController do
  use TwoMinutes.Web, :controller

  plug Ueberauth

  alias TwoMinutes.Account


  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = 
      case auth.provider do
        :facebook -> 
          %{uid: auth.uid, name: auth.info.name, avatar: auth.info.image}
        :google -> 
          %{name: auth.info.name, email: auth.info.email, avatar: auth.info.image} 
      end

    case create_or_get_user(user_params) do
      {:ok, user} -> 
        conn
        |> put_session(:current_user, user)
        |> put_flash(:info, "SignIn Successful")
        |> redirect(to: page_path(conn, :index))
      {:error, _changeset} -> 
        conn
        |> put_flash(:error, "Something Went Wrong")
        |> redirect(to: session_path(conn, :new))
    end
  end

  defp create_or_get_user(user_params) do
    user = 
      cond do
        Map.has_key?(user_params, :uid) -> 
          Account.get_user_from_facebook(to_string(user_params.uid))
        true -> 
          Account.get_user_from_google(user_params.email)
      end

    cond do
      user -> {:ok, user}
      Map.has_key?(user_params, :uid) -> Account.create_facebook_user(user_params)
      true -> Account.create_google_user(user_params)
    end
  end
end