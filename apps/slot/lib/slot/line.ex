defmodule Slot.Line do
  @doc """
  Returns a list with only the sequence that is the same as the first element or :wild
  """
  def sequence([head | tail]) do
    [head | sequence(tail, head)]
  end

  defp sequence([head | tail], symbol) when head == symbol or head == :wild do
    [head | sequence(tail, symbol)]
  end

  defp sequence([head | tail], symbol) when head !== symbol and symbol == :wild do
    [head | sequence(tail, head)]
  end

  defp sequence(_line, _symbol) do
    []
  end

  @doc """
  Replaces the :wild in a `line` with the corresponding symbol.
  """
  def replace_wilds(line) do
    elements = Enum.uniq(line) |> Enum.sort()

    case elements do
      [:wild] -> Enum.map(line, fn _ -> :sym1 end)
      [sym, :wild] -> Enum.map(line, fn _ -> sym end)
      [_sym] -> line
      _ -> :error
    end
  end
end
