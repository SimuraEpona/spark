defmodule SparkWeb.TagsController do
  use SparkWeb, :controller

  alias Spark.Blog

  def show(conn, %{"id" => tag}) do
    render(conn, "show.html", posts: Blog.get_posts_by_tag!(tag), tag: tag)
  end
end
