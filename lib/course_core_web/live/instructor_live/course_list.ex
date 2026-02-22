defmodule CourseCoreWeb.InstructorLive.CourseList do
  use CourseCoreWeb, :live_view

  alias CourseCore.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "My Courses",
       current_page: :courses,
       breadcrumbs: [%{label: "Courses"}],
       active_course: nil
     )}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    # In a real app, we would load courses for the current user
    # courses = Catalog.list_courses_by_user(socket.assigns.current_user.id)
    # For now, let's just assign an empty list to test the empty state
    {:noreply, assign(socket, courses: [])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-8">
      <div class="flex justify-between items-end">
        <div>
          <h2 class="text-2xl font-bold text-slate-900 dark:text-slate-100 mb-1">My Courses</h2>
          <p class="text-slate-500">Manage and publish your educational content.</p>
        </div>
        <button
          phx-click={JS.patch(~p"/instructor/courses/new")}
          class="px-4 py-2.5 bg-primary text-white font-semibold rounded-lg flex items-center gap-2 shadow-lg shadow-primary/20 hover:bg-primary/90 transition-all"
        >
          <.icon name="hero-plus" class="size-5" />
          <span>Create Course</span>
        </button>
      </div>

      <div
        :if={Enum.empty?(@courses)}
        class="bg-white dark:bg-slate-900 rounded-2xl border-2 border-dashed border-slate-200 dark:border-slate-800 p-12 text-center"
      >
        <div class="size-16 bg-slate-50 dark:bg-slate-800 rounded-full flex items-center justify-center mx-auto mb-4 text-slate-400">
          <.icon name="hero-book-open" class="size-8" />
        </div>
        <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-2">No courses found</h3>
        <p class="text-slate-500 mb-8 max-w-sm mx-auto">
          You haven't created any courses yet. Start by creating your first course to share your knowledge with the world.
        </p>
        <button
          phx-click={JS.patch(~p"/instructor/courses/new")}
          class="inline-flex items-center gap-2 px-6 py-3 bg-primary text-white font-bold rounded-xl hover:scale-105 transition-transform"
        >
          <.icon name="hero-sparkles" class="size-5" /> Create your first course
        </button>
      </div>

      <div :if={!Enum.empty?(@courses)} class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div
          :for={course <- @courses}
          class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 overflow-hidden shadow-sm hover:shadow-md transition-shadow group"
        >
          <div class="aspect-video bg-slate-100 dark:bg-slate-800 flex items-center justify-center relative">
            <.icon name="hero-photo" class="size-12 text-slate-300" />
            <div class="absolute top-3 right-3">
              <span class={[
                "px-2 py-1 rounded-lg text-[10px] font-bold uppercase tracking-wider",
                course.status == "published" &&
                  "bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400",
                course.status == "draft" &&
                  "bg-slate-100 text-slate-600 dark:bg-slate-800 dark:text-slate-400"
              ]}>
                {course.status}
              </span>
            </div>
          </div>
          <div class="p-6">
            <h4 class="font-bold text-slate-900 dark:text-white mb-2 group-hover:text-primary transition-colors">
              {course.title}
            </h4>
            <div class="flex items-center justify-between text-sm text-slate-500">
              <div class="flex items-center gap-1">
                <.icon name="hero-users" class="size-4" />
                <span>0 students</span>
              </div>
              <div class="font-semibold text-slate-900 dark:text-white">
                ${course.price_cents / 100}
              </div>
            </div>
          </div>
          <div class="px-6 py-4 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-200 dark:border-slate-800 flex gap-3">
            <.link
              patch={~p"/instructor/courses/#{course.id}/edit"}
              class="flex-1 py-2 text-center text-sm font-semibold bg-white dark:bg-slate-700 border border-slate-200 dark:border-slate-600 rounded-lg hover:bg-slate-50 dark:hover:bg-slate-600 transition-colors"
            >
              Edit Course
            </.link>
            <button class="px-3 py-2 text-slate-400 hover:text-red-500 transition-colors">
              <.icon name="hero-trash" class="size-5" />
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
