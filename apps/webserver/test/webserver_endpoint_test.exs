defmodule Webserver.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Webserver.Endpoint.init([])

  test "status is ok" do
    conn = conn(:get, "/status")
    conn = Webserver.Endpoint.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK"
  end

  test "returns 200 OK with valid request body" do
    conn = conn(:get, "/spin")
    conn = Webserver.Endpoint.call(conn, @opts)

    assert conn.status == 200
  end
end
