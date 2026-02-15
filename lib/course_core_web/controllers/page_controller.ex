defmodule CourseCoreWeb.PageController do
  use CourseCoreWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
