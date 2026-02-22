defmodule CourseCore.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :price_cents, :integer
      add :status, :string, default: "draft", null: false
      add :slug, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:courses, [:user_id])
    create unique_index(:courses, [:slug])
  end
end
