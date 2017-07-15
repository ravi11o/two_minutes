defmodule TwoMinutes.Web.Plugs.AuthenticateAdmin do
  
  import Phoenix.Controller
  import Plug.Conn
  alias TwoMinutes.Web.Router.Helpers

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns.current_user && conn.assigns.current_user.is_admin do
      conn
    else 
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: Helpers.user_path(conn, :index))
      |> halt()
    end
  end
end