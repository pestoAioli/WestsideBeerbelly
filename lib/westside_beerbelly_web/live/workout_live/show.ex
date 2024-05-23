defmodule WestsideBeerbellyWeb.WorkoutLive.Show do
  use WestsideBeerbellyWeb, :live_view

  alias WestsideBeerbelly.Workouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:workout, Workouts.get_workout!(id))}
  end

  defp page_title(:show), do: "Show Workout"
  defp page_title(:edit), do: "Edit Workout"
end
