defmodule WestsideBeerbellyWeb.WorkoutLive.ByDate do
  use WestsideBeerbellyWeb, :live_view

  alias WestsideBeerbelly.Workouts
  # alias WestsideBeerbelly.Workouts.Workout

  on_mount {WestsideBeerbellyWeb.UserAuth, :mount_current_user}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:workouts, [])
     |> assign_form(%{})}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Choose by date")
  end

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  @impl true
  def handle_event("find", %{"date" => date}, socket) do
    IO.inspect(date)

    socket = stream(socket, :workouts, [], reset: true)

    {:noreply,
     stream(
       socket,
       :workouts,
       Workouts.get_workouts_by_date(socket.assigns.current_user.id, date)
     )}
  end
end
