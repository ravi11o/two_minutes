defmodule TwoMinutes.Web.PageController do
  use TwoMinutes.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
