defmodule CourseCoreWeb.InstructorComponents do
  @moduledoc """
  Components for the instructor dashboard area.
  """
  use Phoenix.Component
  use Gettext, backend: CourseCoreWeb.Gettext

  alias Phoenix.LiveView.JS
  import CourseCoreWeb.CoreComponents

  # verified_routes
  use Phoenix.VerifiedRoutes,
    endpoint: CourseCoreWeb.Endpoint,
    router: CourseCoreWeb.Router,
    statics: CourseCoreWeb.static_paths()

  @doc """
  Renders the instructor sidebar.
  """
  attr :current_page, :atom, default: :dashboard
  attr :current_user, :any, required: true

  def sidebar(assigns) do
    ~H"""
    <aside class="w-64 flex-shrink-0 bg-slate-900 border-r border-slate-800 flex flex-col justify-between h-screen sticky top-0">
      <div class="p-6">
        <!-- Brand -->
        <div class="flex items-center gap-3 mb-10 px-2">
          <div class="bg-primary rounded-lg p-1.5 flex items-center justify-center">
            <.icon name="hero-book-open-solid" class="text-white size-6" />
          </div>
          <h1 class="text-white text-xl font-bold tracking-tight">EduStream</h1>
        </div>
        
    <!-- Nav Links -->
        <nav class="space-y-1">
          <.nav_link
            id="nav-dashboard"
            active={@current_page == :dashboard}
            patch={~p"/instructor"}
            label="Dashboard"
            icon="hero-squares-2x2"
          />
          <.nav_link
            id="nav-courses"
            active={@current_page == :courses}
            patch={~p"/instructor/courses"}
            label="Courses"
            icon="hero-book-open"
          />
          <.nav_link
            id="nav-students"
            active={@current_page == :students}
            href="#"
            label="Students"
            icon="hero-users"
          />
          <.nav_link
            id="nav-revenue"
            active={@current_page == :revenue}
            href="#"
            label="Revenue"
            icon="hero-banknotes"
          />
          <.nav_link
            id="nav-settings"
            active={@current_page == :settings}
            patch={~p"/users/settings"}
            label="Settings"
            icon="hero-cog-6-tooth"
          />
        </nav>
      </div>
      
    <!-- Sidebar Bottom -->
      <div class="p-6 border-t border-slate-800">
        <div class="flex items-center justify-between px-2 mb-4">
          <div class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-full bg-slate-700 flex items-center justify-center text-xs text-white font-bold">
              {String.slice(@current_user.email, 0, 2) |> String.upcase()}
            </div>
            <div class="flex flex-col">
              <span class="text-xs font-semibold text-white">{@current_user.email}</span>
              <span class="text-[10px] text-slate-500 uppercase tracking-wider">Instructor</span>
            </div>
          </div>
          <a href={~p"/users/log-out"} method="delete" class="text-slate-400 hover:text-white">
            <.icon name="hero-arrow-right-start-on-rectangle" class="size-5" />
          </a>
        </div>
        <button
          phx-click={JS.dispatch("phx:set-theme", detail: %{theme: "dark"})}
          class="flex items-center justify-center gap-2 w-full py-2 bg-slate-800 rounded-lg text-slate-300 text-sm font-medium hover:bg-slate-700 transition-colors"
        >
          <.icon name="hero-moon" class="size-5" />
          <span>Dark Mode</span>
        </button>
      </div>
    </aside>
    """
  end

  attr :active, :boolean, default: false
  attr :label, :string, required: true
  attr :icon, :string, required: true
  attr :id, :string, required: true
  attr :rest, :global, include: ~w(href patch navigate)

  defp nav_link(assigns) do
    ~H"""
    <.link
      id={@id}
      class={[
        "flex items-center gap-3 px-3 py-2.5 rounded-lg transition-all group font-medium",
        @active && "bg-primary text-white",
        !@active && "text-slate-400 hover:bg-slate-800 hover:text-white"
      ]}
      {@rest}
    >
      <.icon
        name={@icon}
        class={"size-5 #{if @active, do: "text-white", else: "text-slate-400 group-hover:text-white"}"}
      />
      <span>{@label}</span>
    </.link>
    """
  end

  @doc """
  Renders the instructor top bar.
  """
  attr :breadcrumbs, :list, default: []
  attr :active_course, :string, default: nil

  def top_bar(assigns) do
    ~H"""
    <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 flex items-center justify-between px-8 z-10 w-full">
      <div class="flex items-center gap-6">
        <!-- Course Context Indicator -->
        <div
          :if={@active_course}
          class="flex items-center gap-3 px-4 py-1.5 bg-primary/10 border border-primary/20 rounded-full"
        >
          <div class="size-2 rounded-full bg-primary"></div>
          <span class="text-primary text-sm font-semibold truncate max-w-[200px]">
            Active: {@active_course}
          </span>
          <.icon name="hero-chevron-down" class="text-primary size-4" />
        </div>
        
    <!-- Breadcrumbs -->
        <nav class="flex items-center text-sm text-slate-500 font-medium overflow-hidden">
          <a class="hover:text-primary whitespace-nowrap" href="/instructor">Home</a>
          <div :for={item <- @breadcrumbs} class="flex items-center">
            <span class="mx-2 text-slate-300">/</span>
            <.link :if={item[:to]} patch={item.to} class="hover:text-primary whitespace-nowrap">
              {item.label}
            </.link>
            <span :if={!item[:to]} class="text-slate-900 dark:text-slate-100 whitespace-nowrap">
              {item.label}
            </span>
          </div>
        </nav>
      </div>

      <div class="flex items-center gap-4">
        <div class="relative hidden sm:block">
          <.icon
            name="hero-magnifying-glass"
            class="text-slate-400 absolute left-3 top-1/2 -translate-y-1/2 size-5"
          />
          <input
            type="text"
            placeholder="Search platform..."
            class="pl-10 pr-4 py-2 bg-slate-100 dark:bg-slate-800 border-none rounded-lg text-sm w-64 focus:ring-2 focus:ring-primary/20 placeholder:text-slate-400 dark:text-white"
          />
        </div>
        <button class="size-10 flex items-center justify-center rounded-lg bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400 hover:bg-slate-200 dark:hover:bg-slate-700 transition-colors relative">
          <.icon name="hero-bell" class="size-6" />
          <span class="absolute top-2 right-2 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-800">
          </span>
        </button>
      </div>
    </header>
    """
  end

  @doc """
  Renders a stat card.
  """
  attr :title, :string, required: true
  attr :value, :string, required: true
  attr :icon, :string, required: true
  # %{value: "+12.5%", color: "text-green-600"}
  attr :trend, :map, default: nil
  attr :color, :string, default: "primary"

  def stat_card(assigns) do
    ~H"""
    <div class="bg-white dark:bg-slate-900 p-6 rounded-xl border border-slate-200 dark:border-slate-800 shadow-sm transition-all hover:shadow-md">
      <div class="flex justify-between items-start mb-4">
        <div class={[
          "size-12 rounded-lg flex items-center justify-center",
          @color == "primary" && "bg-blue-50 dark:bg-blue-900/20 text-primary",
          @color == "green" && "bg-green-50 dark:bg-green-900/20 text-green-600",
          @color == "purple" && "bg-purple-50 dark:bg-purple-900/20 text-purple-600"
        ]}>
          <.icon name={@icon} class="size-7" />
        </div>
        <span
          :if={@trend}
          class={[
            "flex items-center gap-1 font-bold text-sm px-2 py-1 rounded",
            @trend.color,
            String.contains?(@trend.color, "green") && "bg-green-50 dark:bg-green-900/20",
            String.contains?(@trend.color, "red") && "bg-red-50 dark:bg-red-900/20",
            String.contains?(@trend.color, "slate") && "bg-slate-50 dark:bg-slate-900/20"
          ]}
        >
          <.icon
            :if={String.contains?(@trend.color, "green")}
            name="hero-arrow-trending-up"
            class="size-4"
          />
          <.icon
            :if={String.contains?(@trend.color, "red")}
            name="hero-arrow-trending-down"
            class="size-4"
          />
          {@trend.value}
        </span>
      </div>
      <p class="text-slate-500 text-sm font-medium mb-1">{@title}</p>
      <h3 class="text-3xl font-bold text-slate-900 dark:text-white">{@value}</h3>
    </div>
    """
  end
end
