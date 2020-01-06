defmodule Webserver.Endpoint do
  @moduledoc """
  A Plug responsible for logging requenst info, parsing request body as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(:dispatch)

  get "/status" do
    send_resp(conn, 200, "OK")
  end

  get "/spin" do
    spin_response = Slot.spin()
    send_resp(conn, 200, Poison.encode!(spin_response))
  end

  match _ do
    send_resp(conn, 404, "Nothing here")
  end

  ### Handlers
  defp process_action(action) do
    Poison.encode!(%{response: "Processing #{action}.."})
  end

  defp wrong_format() do
    Poison.encode!(%{response: "Wrong format on the request missing action."})
  end
end
