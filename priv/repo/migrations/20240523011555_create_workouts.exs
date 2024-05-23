defmodule WestsideBeerbelly.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :type, :string
      add :date, :date
      add :name, :string
      add :weight, :float
      add :reps, :integer
      add :sets, :integer
      add :comments, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:workouts, [:user_id])
  end
end
