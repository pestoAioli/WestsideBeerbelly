defmodule WestsideBeerbellyWeb.PageLive do
  use WestsideBeerbellyWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>hello</div>
    """
  end
end
