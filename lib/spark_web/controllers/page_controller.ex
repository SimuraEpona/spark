defmodule SparkWeb.PageController do
  use SparkWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
