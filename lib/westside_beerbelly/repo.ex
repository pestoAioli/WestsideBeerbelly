defmodule WestsideBeerbelly.Repo do
  use Ecto.Repo,
    otp_app: :westside_beerbelly,
    adapter: Ecto.Adapters.Postgres
end
