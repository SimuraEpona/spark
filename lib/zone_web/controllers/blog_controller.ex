defmodule ZoneWeb.BlogController do
  use ZoneWeb, :controller

  alias Zone.Blog

  def index(conn, _params) do
    render(conn, "index.html", posts: Blog.all_posts())
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post_by_id!(id)
    render(conn, "show.html", post: post, page_title: post.title)
  end
end
