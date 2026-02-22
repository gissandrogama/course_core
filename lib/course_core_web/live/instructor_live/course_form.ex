defmodule CourseCoreWeb.InstructorLive.CourseForm do
  use CourseCoreWeb, :live_view

  alias CourseCore.Catalog

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: if(params["id"], do: "Edit Course", else: "Create New Course"),
       current_page: :courses,
       active_course: nil,
       breadcrumbs: [
         %{label: "Courses", to: ~p"/instructor/courses"},
         %{label: if(params["id"], do: "Edit", else: "New")}
       ]
     )}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-3xl mx-auto">
      <div class="mb-8">
        <.link
          patch={~p"/instructor/courses"}
          class="text-primary text-sm font-semibold flex items-center gap-1 mb-4 hover:underline"
        >
          <.icon name="hero-arrow-left" class="size-4" /> Back to courses
        </.link>
        <h2 class="text-2xl font-bold text-slate-900 dark:text-white">{@page_title}</h2>
        <p class="text-slate-500">Fill in the details below to set up your course.</p>
      </div>

      <div class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 p-8 shadow-sm">
        <p class="text-center text-slate-500 py-12 italic">
          Course form implementation in progress... (ISSUE-004)
        </p>
      </div>
    </div>
    """
  end
end
