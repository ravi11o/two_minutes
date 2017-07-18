defmodule TwoMinutes.Web.PageController do
  use TwoMinutes.Web, :controller

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    render conn, "index.html"
  end
end
