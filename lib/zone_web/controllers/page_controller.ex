defmodule ZoneWeb.PageController do
  use ZoneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
