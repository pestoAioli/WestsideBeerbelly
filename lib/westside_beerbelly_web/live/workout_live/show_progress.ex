defmodule WestsideBeerbellyWeb.WorkoutLive.ShowProgress do
  alias Contex.Dataset
  use WestsideBeerbellyWeb, :live_view

  alias WestsideBeerbelly.Workouts
  alias Contex.{LinePlot, Plot}

  on_mount {WestsideBeerbellyWeb.UserAuth, :mount_current_user}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    workout = Workouts.get_workout!(id)
    [type_match | _rest] = String.split(workout.type, " ")

    {:noreply,
     socket
     |> assign(:page_title, "See your progress")
     |> assign(
       :workouts,
       Workouts.get_workouts_by_name_and_type(
         socket.assigns.current_user.id,
         workout.name,
         type_match
       )
       |> Enum.map(fn w -> {DateTime.new!(w.date, ~T[00:00:00]), w.weight} end)
       |> IO.inspect()
     )
     |> assign(:workout, workout)}
  end

  def build_plot_point(dataset) do
    ds = Dataset.new(dataset, ["x", "y"])

    plot = Plot.new(ds, LinePlot, 600, 400)

    Plot.to_svg(plot)
  end
end
