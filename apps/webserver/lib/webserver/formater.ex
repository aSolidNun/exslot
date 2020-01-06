defmodule Webserver.Formatter do
    defimpl Poison.Encoder, for: Slot.SpinResult do
        def encode(spin_result, _options) do
            "{\"payout\": " <> to_string(spin_result.payout) <> "}"
        end
    end
end