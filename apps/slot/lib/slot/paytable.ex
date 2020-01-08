defmodule Slot.Paytable do
  def line_win(line, paytable) do
    Map.get(paytable, line, 0)
  end
end
