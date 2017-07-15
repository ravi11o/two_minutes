defmodule TwoMinutes.Web.Router do
  use TwoMinutes.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug TwoMinutes.Web.Plugs.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TwoMinutes.Web do
    pipe_through [:browser, :browser_session] 

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/session", TwoMinutes.Web do
    pipe_through [:browser, :browser_session]

    get "/new", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", TwoMinutes.Web do
  #   pipe_through :api
  # end
end
