defmodule TwoMinutes.Web.SessionController do
  use TwoMinutes.Web, :controller

  alias TwoMinutes.Account
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]


  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case login_by_email_and_password(conn, email, pass) do
      {:ok, conn} -> 
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))

      {:error, _reason, conn} -> 
        conn
        |> put_flash(:error, "Invalid Email/Password Combination")
        |> render("new.html")
    end
  end

  defp login_by_email_and_password(conn, email, password) do
    user = Account.get_by_email(email)

    cond do
      user && checkpw(password, user.hashed_password) -> 
        {:ok, login(conn, user)}
      user -> 
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  defp login(conn, user) do
    Guardian.Plug.sign_in(conn, user)
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: page_path(conn, :index))
  end
end