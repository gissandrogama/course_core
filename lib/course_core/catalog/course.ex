defmodule CourseCore.Catalog.Course do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "courses" do
    field :title, :string
    field :description, :string
    field :price_cents, :integer
    field :status, :string, default: "draft"
    field :slug, :string
    belongs_to :user, CourseCore.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @status_values ~w(draft published archived)

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:title, :description, :price_cents, :status, :slug, :user_id])
    |> validate_required([:title, :status, :slug, :user_id])
    |> validate_number(:price_cents, greater_than_or_equal_to: 0)
    |> validate_inclusion(:status, @status_values)
    |> unique_constraint(:slug)
  end
end
