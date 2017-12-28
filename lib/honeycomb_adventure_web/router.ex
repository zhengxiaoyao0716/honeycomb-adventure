defmodule HoneycombAdventureWeb.Router do
  use HoneycombAdventureWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    plug = if Mix.env == :dev do
      Absinthe.Plug.GraphiQL
    else
      Absinthe.Plug
    end
    forward "/", plug,
      schema: HoneycombAdventureWeb.Schema,
      socket: HoneycombAdventureWeb.UserSocket
  end

  scope "/", HoneycombAdventureWeb do
    pipe_through :browser # Use the default browser stack

    get "/*page", PageController, :index
  end
end
