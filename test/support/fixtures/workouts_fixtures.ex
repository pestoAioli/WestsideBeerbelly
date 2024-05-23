defmodule WestsideBeerbelly.WorkoutsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WestsideBeerbelly.Workouts` context.
  """

  @doc """
  Generate a workout.
  """
  def workout_fixture(attrs \\ %{}) do
    {:ok, workout} =
      attrs
      |> Enum.into(%{
        comments: "some comments",
        date: ~D[2024-05-22],
        name: "some name",
        reps: 42,
        sets: 42,
        type: "some type",
        weight: 120.5
      })
      |> WestsideBeerbelly.Workouts.create_workout()

    workout
  end
end
