defmodule WestsideBeerbellyWeb.HomeLive.Index do
  use WestsideBeerbellyWeb, :live_view

  on_mount {WestsideBeerbellyWeb.UserAuth, :mount_current_user}

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
