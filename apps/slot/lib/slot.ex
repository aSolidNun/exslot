defmodule Slot do

  def spin() do
    spin_configuration = Slot.Rules.spin_configuration()

    outcome = spin_configuration.reels
    |> Enum.map(fn {reel, positions} -> Slot.Reel.reel_stop(reel, positions) end)
    |> Enum.concat()
    |> Enum.into(%{})

    wins = calculate_wins(outcome, Slot.Rules.lines())

    payout = Enum.reduce(wins, 0, fn ({_, {_, payout}}, total) -> total + payout end)

    %Slot.SpinResult{outcome: outcome, wins: wins, payout: payout}    
    
  end

  defp calculate_wins(outcome, lines) do
    Enum.map(Keyword.keys(lines), fn line -> {line, process_line(outcome, lines[line])} end)
    |> Enum.reject(fn {_, {_, payout}} -> payout == 0 end)
    |> Map.new
  end

  defp process_line(outcome, line) do
    sequence = Enum.map(line, fn pos -> outcome[pos] end)
    |> Slot.Line.sequence()

    win = Slot.Line.replace_wilds(sequence)
    |> Slot.Paytable.line_win(Slot.Rules.paytable())

    if win > 0 do
      {sequence, win}
    else 
      {line, win}
    end
  end

end
