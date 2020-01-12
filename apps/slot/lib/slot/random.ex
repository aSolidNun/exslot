defmodule Slot.Random do
  @doc """
  Returns random strip from the given `reel` and zip them with the given `positions`.
  """
  def reel_stop(reel, positions) do
    strip = take_at(reel, random_index(reel), length(positions))
    Enum.zip(positions, strip)
  end

  @doc """
  Returns random outcome for the given `reel` and `configuration` at the specified `positions`.
  The returned value has the following format:
  [{position, outcome}]
  """
  def outcome(reel, positions, configuration) 

  def outcome(reel, positions, %{:mode => :any}) do
    for position <- positions, do: {position, Enum.random(reel)}
  end

  def outcome(reel, positions, %{:mode => :sequence}) do
    strip = take_at(reel, random_index(reel), length(positions))
    Enum.zip(positions, strip)
  end

  defp take_at(reel, at, count) do
    Stream.cycle(reel)
    |> Enum.take(at + count)
    |> Enum.take(count * -1)
  end

  defp random_index(reel) do
    Enum.random(0..(Enum.count(reel) - 1))
  end
end

