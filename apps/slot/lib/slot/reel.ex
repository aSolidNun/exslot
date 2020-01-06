defmodule Slot.Reel do
    @doc """
    Returns random strip from the given `reel` and zip them with the given `positions`.
    """
    def reel_stop(reel, positions) do
        strip = take_at(reel, outcome(reel), length(positions))
        Enum.zip(positions, strip)
    end

    defp take_at(reel, at, count) do
        Stream.cycle(reel)
        |> Enum.take(at + count)
        |> Enum.take(count * -1)
    end

    defp outcome(reel) do
        Enum.random(0..Enum.count(reel) - 1)
    end

end