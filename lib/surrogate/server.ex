defmodule Surrogate.Server do
  import Plug.Conn

  def init(_) do
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("application/text")
    |> send_resp(200, "OK")
  end
end
