defmodule WestsideBeerbellyWeb.PageLive do
  use WestsideBeerbellyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= if @current_user do %>
        Welcome back, <%= @current_user.name %>
      <% end %>
    </div>
    """
  end
end
