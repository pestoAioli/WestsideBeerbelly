defmodule WestsideBeerbellyWeb.WorkoutLiveTest do
  use WestsideBeerbellyWeb.ConnCase

  import Phoenix.LiveViewTest
  import WestsideBeerbelly.WorkoutsFixtures

  @create_attrs %{name: "some name", type: "some type", date: "2024-05-22", sets: 42, comments: "some comments", weight: 120.5, reps: 42}
  @update_attrs %{name: "some updated name", type: "some updated type", date: "2024-05-23", sets: 43, comments: "some updated comments", weight: 456.7, reps: 43}
  @invalid_attrs %{name: nil, type: nil, date: nil, sets: nil, comments: nil, weight: nil, reps: nil}

  defp create_workout(_) do
    workout = workout_fixture()
    %{workout: workout}
  end

  describe "Index" do
    setup [:create_workout]

    test "lists all workouts", %{conn: conn, workout: workout} do
      {:ok, _index_live, html} = live(conn, ~p"/workouts")

      assert html =~ "Listing Workouts"
      assert html =~ workout.name
    end

    test "saves new workout", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/workouts")

      assert index_live |> element("a", "New Workout") |> render_click() =~
               "New Workout"

      assert_patch(index_live, ~p"/workouts/new")

      assert index_live
             |> form("#workout-form", workout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#workout-form", workout: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/workouts")

      html = render(index_live)
      assert html =~ "Workout created successfully"
      assert html =~ "some name"
    end

    test "updates workout in listing", %{conn: conn, workout: workout} do
      {:ok, index_live, _html} = live(conn, ~p"/workouts")

      assert index_live |> element("#workouts-#{workout.id} a", "Edit") |> render_click() =~
               "Edit Workout"

      assert_patch(index_live, ~p"/workouts/#{workout}/edit")

      assert index_live
             |> form("#workout-form", workout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#workout-form", workout: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/workouts")

      html = render(index_live)
      assert html =~ "Workout updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes workout in listing", %{conn: conn, workout: workout} do
      {:ok, index_live, _html} = live(conn, ~p"/workouts")

      assert index_live |> element("#workouts-#{workout.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#workouts-#{workout.id}")
    end
  end

  describe "Show" do
    setup [:create_workout]

    test "displays workout", %{conn: conn, workout: workout} do
      {:ok, _show_live, html} = live(conn, ~p"/workouts/#{workout}")

      assert html =~ "Show Workout"
      assert html =~ workout.name
    end

    test "updates workout within modal", %{conn: conn, workout: workout} do
      {:ok, show_live, _html} = live(conn, ~p"/workouts/#{workout}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Workout"

      assert_patch(show_live, ~p"/workouts/#{workout}/show/edit")

      assert show_live
             |> form("#workout-form", workout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#workout-form", workout: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/workouts/#{workout}")

      html = render(show_live)
      assert html =~ "Workout updated successfully"
      assert html =~ "some updated name"
    end
  end
end
