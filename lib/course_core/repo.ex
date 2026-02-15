defmodule CourseCore.Repo do
  use Ecto.Repo,
    otp_app: :course_core,
    adapter: Ecto.Adapters.Postgres
end
