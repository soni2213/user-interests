defmodule UserInterests.PageController do
  use UserInterests.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
