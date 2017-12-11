defmodule HoneycombAdventureWeb.PageController do
  use HoneycombAdventureWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
