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

    post "/spin" do
        {status, body} = 
            case conn.body_params do
                %{"action" => action} -> {200, process_action(action)}
                _ -> {200, wrong_format()}
            end
        send_resp(conn, status, body)
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