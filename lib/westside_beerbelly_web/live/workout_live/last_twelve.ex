defmodule WestsideBeerbellyWeb.WorkoutLive.LastTwelve do
  use WestsideBeerbellyWeb, :live_view

  alias WestsideBeerbelly.Workouts
  # alias WestsideBeerbelly.Workouts.Workout

  on_mount {WestsideBeerbellyWeb.UserAuth, :mount_current_user}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :workouts, Workouts.get_last_twelve_max(socket.assigns.current_user.id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Last Twelve Max Days")
    |> assign(:workout, nil)
  end
end
