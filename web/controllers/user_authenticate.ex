defmodule UserInterests.Plugs.Authenticate do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _params) do
    case current_user(conn) do
      nil ->
        conn
        |> send_resp(403, "Missing valid API token")
        |> halt
      user ->
        assign(conn, :user, user)
    end
  end

  defp current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
