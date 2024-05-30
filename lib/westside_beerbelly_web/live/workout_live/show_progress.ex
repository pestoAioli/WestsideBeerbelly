defmodule WestsideBeerbellyWeb.WorkoutLive.ShowProgress do
  use WestsideBeerbellyWeb, :live_view

  alias WestsideBeerbelly.Workouts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    IO.inspect(id)

    {:noreply,
     socket
     |> assign(:page_title, "See your progress")
     |> assign(:workout, Workouts.get_workout!(id))}
  end
end
