defmodule CourseCore.CatalogTest do
  use CourseCore.DataCase

  alias CourseCore.Catalog

  describe "courses" do
    alias CourseCore.Catalog.Course

    import CourseCore.CatalogFixtures

    @invalid_attrs %{status: nil, description: nil, title: nil, price_cents: nil, slug: nil}

    test "list_courses/0 returns all courses" do
      course = course_fixture()
      assert Catalog.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert Catalog.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      valid_attrs = %{
        status: "some status",
        description: "some description",
        title: "some title",
        price_cents: 42,
        slug: "some slug"
      }

      assert {:ok, %Course{} = course} = Catalog.create_course(valid_attrs)
      assert course.status == "some status"
      assert course.description == "some description"
      assert course.title == "some title"
      assert course.price_cents == 42
      assert course.slug == "some slug"
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()

      update_attrs = %{
        status: "some updated status",
        description: "some updated description",
        title: "some updated title",
        price_cents: 43,
        slug: "some updated slug"
      }

      assert {:ok, %Course{} = course} = Catalog.update_course(course, update_attrs)
      assert course.status == "some updated status"
      assert course.description == "some updated description"
      assert course.title == "some updated title"
      assert course.price_cents == 43
      assert course.slug == "some updated slug"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_course(course, @invalid_attrs)
      assert course == Catalog.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = Catalog.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = Catalog.change_course(course)
    end
  end
end
