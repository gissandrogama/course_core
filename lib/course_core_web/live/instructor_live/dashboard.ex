defmodule CourseCoreWeb.InstructorLive.Dashboard do
  use CourseCoreWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Instructor Dashboard",
       current_page: :dashboard,
       active_course: "Advanced Python Masterclass",
       breadcrumbs: []
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="space-y-8">
      <!-- Welcome Section -->
      <div class="flex flex-col sm:flex-row justify-between items-start sm:items-end gap-4">
        <div>
          <h2 class="text-2xl font-bold text-slate-900 dark:text-slate-100 mb-1">
            Dashboard Overview
          </h2>
          <p class="text-slate-500">Monitor your course performance and student engagement.</p>
        </div>
        <button class="px-4 py-2.5 bg-primary text-white font-semibold rounded-lg flex items-center gap-2 shadow-lg shadow-primary/20 hover:bg-primary/90 transition-all">
          <.icon name="hero-plus" class="size-5" />
          <span>Create Course</span>
        </button>
      </div>
      
    <!-- Stats Grid -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <.stat_card
          title="Total Students"
          value="12,840"
          icon="hero-users"
          color="primary"
          trend={%{value: "12.5%", color: "text-green-600"}}
        />
        <.stat_card
          title="Total Sales"
          value="$45,200.00"
          icon="hero-banknotes"
          color="green"
          trend={%{value: "8.2%", color: "text-green-600"}}
        />
        <.stat_card
          title="Active Courses"
          value="14"
          icon="hero-book-open"
          color="purple"
          trend={%{value: "0%", color: "text-slate-400"}}
        />
      </div>
      
    <!-- Recent Enrollments Table -->
      <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm overflow-hidden">
        <div class="px-6 py-5 border-b border-slate-200 dark:border-slate-800 flex items-center justify-between">
          <h3 class="font-bold text-lg text-slate-900 dark:text-white">Recent Enrollments</h3>
          <button class="text-primary text-sm font-semibold hover:underline">View All</button>
        </div>
        <div class="overflow-x-auto">
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="bg-slate-50 dark:bg-slate-800/50">
                <th class="px-6 py-4 text-xs font-bold uppercase tracking-wider text-slate-500 text-nowrap">
                  Student Name
                </th>
                <th class="px-6 py-4 text-xs font-bold uppercase tracking-wider text-slate-500 text-nowrap">
                  Course
                </th>
                <th class="px-6 py-4 text-xs font-bold uppercase tracking-wider text-slate-500 text-nowrap">
                  Date
                </th>
                <th class="px-6 py-4 text-xs font-bold uppercase tracking-wider text-slate-500 text-nowrap">
                  Amount
                </th>
                <th class="px-6 py-4 text-xs font-bold uppercase tracking-wider text-slate-500 text-nowrap">
                  Status
                </th>
              </tr>
            </thead>
            <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
              <tr
                :for={i <- 1..4}
                class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors group"
              >
                <td class="px-6 py-4">
                  <div class="flex items-center gap-3">
                    <div class="size-8 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center text-xs font-bold text-slate-500">
                      {["JD", "MS", "AW", "RL"] |> Enum.at(i - 1)}
                    </div>
                    <span class="font-medium text-slate-900 dark:text-slate-100">
                      {["Jane Doe", "Mark Smith", "Alice Wong", "Robert Lee"] |> Enum.at(i - 1)}
                    </span>
                  </div>
                </td>
                <td class="px-6 py-4 text-sm text-slate-600 dark:text-slate-400">
                  {if rem(i, 2) == 0, do: "Advanced Python Masterclass", else: "React for Beginners"}
                </td>
                <td class="px-6 py-4 text-sm text-slate-600 dark:text-slate-400">
                  Oct {24 - i}, 2023
                </td>
                <td class="px-6 py-4 text-sm font-semibold text-slate-900 dark:text-slate-100">
                  $199.00
                </td>
                <td class="px-6 py-4">
                  <span class={[
                    "px-2.5 py-1 rounded-full text-xs font-bold",
                    if(i == 3,
                      do: "bg-yellow-100 text-yellow-700 dark:bg-yellow-900/30 dark:text-yellow-400",
                      else: "bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400"
                    )
                  ]}>
                    {if i == 3, do: "Pending", else: "Completed"}
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    """
  end
end
