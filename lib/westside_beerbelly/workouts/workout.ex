defmodule WestsideBeerbelly.Workouts.Workout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workouts" do
    field :name, :string
    field :type, :string
    field :date, :date
    field :sets, :integer
    field :comments, :string
    field :weight, :float
    field :reps, :integer
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(workout, attrs) do
    workout
    |> cast(attrs, [:type, :date, :name, :weight, :reps, :sets, :comments])
    |> validate_required([:type, :date, :name, :weight, :reps, :sets, :comments])
  end
end
