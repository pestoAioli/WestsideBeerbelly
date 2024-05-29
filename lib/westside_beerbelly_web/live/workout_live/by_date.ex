defmodule WestsideBeerbellyWeb.WorkoutLive.ByDate do
  use WestsideBeerbellyWeb, :live_view

  alias WestsideBeerbelly.Workouts
  # alias WestsideBeerbelly.Workouts.Workout

  on_mount {WestsideBeerbellyWeb.UserAuth, :mount_current_user}

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:date_selected, nil)
     |> assign_form(%{})}
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

  defp assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  @impl true
  def handle_event("find", %{"date" => date}, socket) do
    IO.inspect(date)

    {:noreply,
     socket
     |> assign(:date_selected, date)}
  end
end
