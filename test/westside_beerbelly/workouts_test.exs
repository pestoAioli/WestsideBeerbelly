defmodule WestsideBeerbelly.WorkoutsTest do
  use WestsideBeerbelly.DataCase

  alias WestsideBeerbelly.Workouts

  describe "workouts" do
    alias WestsideBeerbelly.Workouts.Workout

    import WestsideBeerbelly.WorkoutsFixtures

    @invalid_attrs %{name: nil, type: nil, date: nil, sets: nil, comments: nil, weight: nil, reps: nil}

    test "list_workouts/0 returns all workouts" do
      workout = workout_fixture()
      assert Workouts.list_workouts() == [workout]
    end

    test "get_workout!/1 returns the workout with given id" do
      workout = workout_fixture()
      assert Workouts.get_workout!(workout.id) == workout
    end

    test "create_workout/1 with valid data creates a workout" do
      valid_attrs = %{name: "some name", type: "some type", date: ~D[2024-05-22], sets: 42, comments: "some comments", weight: 120.5, reps: 42}

      assert {:ok, %Workout{} = workout} = Workouts.create_workout(valid_attrs)
      assert workout.name == "some name"
      assert workout.type == "some type"
      assert workout.date == ~D[2024-05-22]
      assert workout.sets == 42
      assert workout.comments == "some comments"
      assert workout.weight == 120.5
      assert workout.reps == 42
    end

    test "create_workout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workouts.create_workout(@invalid_attrs)
    end

    test "update_workout/2 with valid data updates the workout" do
      workout = workout_fixture()
      update_attrs = %{name: "some updated name", type: "some updated type", date: ~D[2024-05-23], sets: 43, comments: "some updated comments", weight: 456.7, reps: 43}

      assert {:ok, %Workout{} = workout} = Workouts.update_workout(workout, update_attrs)
      assert workout.name == "some updated name"
      assert workout.type == "some updated type"
      assert workout.date == ~D[2024-05-23]
      assert workout.sets == 43
      assert workout.comments == "some updated comments"
      assert workout.weight == 456.7
      assert workout.reps == 43
    end

    test "update_workout/2 with invalid data returns error changeset" do
      workout = workout_fixture()
      assert {:error, %Ecto.Changeset{}} = Workouts.update_workout(workout, @invalid_attrs)
      assert workout == Workouts.get_workout!(workout.id)
    end

    test "delete_workout/1 deletes the workout" do
      workout = workout_fixture()
      assert {:ok, %Workout{}} = Workouts.delete_workout(workout)
      assert_raise Ecto.NoResultsError, fn -> Workouts.get_workout!(workout.id) end
    end

    test "change_workout/1 returns a workout changeset" do
      workout = workout_fixture()
      assert %Ecto.Changeset{} = Workouts.change_workout(workout)
    end
  end
end
