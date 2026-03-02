defmodule CourseCoreWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use CourseCoreWeb, :html

  embed_templates "layouts/*"

  @doc """
  Renders your app layout.
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :current_scope, :map, default: nil, doc: "the current user scope"
  slot :inner_block, required: true

  def app(assigns) do
    ~H"""
    <div class="min-h-screen bg-base-200 flex">
      <!-- Sidebar -->
      <aside class="hidden lg:flex flex-col w-64 bg-base-100 border-r border-base-300 h-screen sticky top-0">
        <div class="p-6 flex items-center gap-3">
          <img src={~p"/images/logo.svg"} width="32" class="text-primary" />
          <span class="text-xl font-bold tracking-tight">CourseCore</span>
        </div>

        <nav class="flex-1 px-4 space-y-2 mt-4">
          <.sidebar_link navigate={~p"/"} icon="hero-home">
            Dashboard
          </.sidebar_link>

          <%= if @current_scope do %>
            <.sidebar_link navigate={~p"/users/settings"} icon="hero-cog-6-tooth">
              Settings
            </.sidebar_link>
          <% end %>
        </nav>

        <div class="p-4 border-t border-base-300">
          <%= if @current_scope do %>
            <div class="flex items-center gap-3 mb-4 px-2">
              <div class="avatar placeholder">
                <div class="bg-neutral text-neutral-content rounded-full w-8">
                  <span class="text-xs">{String.at(@current_scope.user.email, 0) |> String.upcase()}</span>
                </div>
              </div>
              <div class="flex-1 min-w-0">
                <p class="text-sm font-medium truncate">{@current_scope.user.email}</p>
              </div>
            </div>
            <.link
              href={~p"/users/log-out"}
              method="delete"
              class="btn btn-sm btn-ghost w-full justify-start gap-3 text-error"
            >
              <.icon name="hero-arrow-right-on-rectangle" class="w-4 h-4" />
              Log out
            </.link>
          <% else %>
            <div class="space-y-2">
              <.link href={~p"/users/log-in"} class="btn btn-primary btn-sm w-full">Log in</.link>
              <.link href={~p"/sign_up"} class="btn btn-outline btn-sm w-full">Register</.link>
            </div>
          <% end %>
        </div>
      </aside>

      <!-- Main Content Area -->
      <div class="flex-1 flex flex-col min-w-0">
        <!-- Mobile Header -->
        <header class="lg:hidden bg-base-100 border-b border-base-300 p-4 flex items-center justify-between sticky top-0 z-20">
          <div class="flex items-center gap-3">
            <img src={~p"/images/logo.svg"} width="28" />
            <span class="font-bold">CourseCore</span>
          </div>
          <!-- Mobile Menu Button could go here, for now simpler implementation -->
          <div class="dropdown dropdown-end">
            <div tabindex="0" role="button" class="btn btn-ghost btn-circle">
              <.icon name="hero-bars-3" class="w-6 h-6" />
            </div>
            <ul tabindex="0" class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-52">
              <li><.link navigate={~p"/"}>Dashboard</.link></li>
              <%= if @current_scope do %>
                <li><.link navigate={~p"/users/settings"}>Settings</.link></li>
                <li><.link href={~p"/users/log-out"} method="delete" class="text-error">Log out</.link></li>
              <% else %>
                <li><.link href={~p"/users/log-in"}>Log in</.link></li>
                <li><.link href={~p"/sign_up"}>Register</.link></li>
              <% end %>
            </ul>
          </div>
        </header>

        <!-- Desktop Header (optional, for breadcrumbs/theme toggle) -->
        <header class="hidden lg:flex items-center justify-between px-8 py-4 bg-base-100/50 backdrop-blur border-b border-base-200 sticky top-0 z-10">
          <div class="text-sm breadcrumbs">
            <ul>
              <li>Home</li>
              <!-- We can make this dynamic later -->
            </ul>
          </div>
          <div class="flex items-center gap-4">
            <.theme_toggle />
          </div>
        </header>

        <main class="flex-1 p-4 lg:p-8 overflow-y-auto">
          <.flash_group flash={@flash} />
          <div class="mx-auto max-w-6xl">
            {render_slot(@inner_block)}
          </div>
        </main>
      </div>
    </div>
    """
  end

  @doc """
  Renders a sidebar link.
  Highlights the link if it matches the current path (basic logic).
  """
  attr :navigate, :string, required: true
  attr :icon, :string, required: true
  slot :inner_block, required: true

  def sidebar_link(assigns) do
    ~H"""
    <a
      href={@navigate}
      data-phx-link="redirect"
      data-phx-link-state="push"
      class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium hover:bg-base-200 transition-colors"
    >
      <.icon name={@icon} class="w-5 h-5 opacity-70" />
      {render_slot(@inner_block)}
    </a>
    """
  end

  @doc """
  Shows the flash group with standard titles and content.
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite" class="mb-6">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />

      <.flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>

      <.flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={show(".phx-server-error #server-error") |> JS.remove_attribute("hidden")}
        phx-connected={hide("#server-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >
        {gettext("Attempting to reconnect")}
        <.icon name="hero-arrow-path" class="ml-1 size-3 motion-safe:animate-spin" />
      </.flash>
    </div>
    """
  end

  @doc """
  Provides dark vs light theme toggle.
  """
  def theme_toggle(assigns) do
    ~H"""
    <div class="join border border-base-300 rounded-full p-0.5">
      <button
        class="join-item px-2 py-1 text-xs hover:bg-base-200 rounded-l-full"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="light"
        aria-label="Light theme"
      >
        <.icon name="hero-sun" class="w-4 h-4" />
      </button>
      <button
        class="join-item px-2 py-1 text-xs hover:bg-base-200"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="system"
        aria-label="System theme"
      >
        <.icon name="hero-computer-desktop" class="w-4 h-4" />
      </button>
      <button
        class="join-item px-2 py-1 text-xs hover:bg-base-200 rounded-r-full"
        phx-click={JS.dispatch("phx:set-theme")}
        data-phx-theme="dark"
        aria-label="Dark theme"
      >
        <.icon name="hero-moon" class="w-4 h-4" />
      </button>
    </div>
    """
  end
end
