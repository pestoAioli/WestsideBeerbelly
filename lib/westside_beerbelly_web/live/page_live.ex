defmodule WestsideBeerbellyWeb.PageLive do
  use WestsideBeerbellyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= if @current_user do %>
        <.header>
          Welcome back, <%= @current_user.name %>. Here are the last 12 max effort exercises you've done:
        </.header>
      <% end %>
    </div>
    """
  end
end
