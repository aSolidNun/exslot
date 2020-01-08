defmodule Webserver.Formatter do
    def format(spin_response) do
        outcome = for {key, val} <- spin_response.outcome, into: %{}, do: {position_to_string(key), val}
        wins = for {key, {syms, _win}} <- spin_response.wins, into: %{}, do: {key, syms}
        %{
            :outcome => outcome,
            :wins => wins
        }    
    end

    defp position_to_string({x, y}) do
        "{#{x},#{y}}"
    end
end
