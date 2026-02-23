defmodule CourseCore.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CourseCore.Catalog` context.
  """

  @doc """
  Generate a course.
  """
  def course_fixture(attrs \\ %{}) do
    {:ok, course} =
      attrs
      |> Enum.into(%{
        description: "some description",
        price_cents: 42,
        slug: "some slug",
        status: "some status",
        title: "some title"
      })
      |> CourseCore.Catalog.create_course()

    course
  end
end
