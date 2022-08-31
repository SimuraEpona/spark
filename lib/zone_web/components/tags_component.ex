defmodule ZoneWeb.Components.TagsComponent do
  use Phoenix.Component

  def tags(assigns) do
    ~H"""
    <span>
      <%= for tag <- @tags do %>
        <.tag tag={tag} />
      <% end %>
    </span>
    """
  end

  def tag(assigns) do
    ~H"""
    <span><a href={"/tags/#{@tag}"}><%= @tag %></a></span>
    """
  end
end
