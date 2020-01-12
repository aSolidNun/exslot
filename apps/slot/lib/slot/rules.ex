defmodule Slot.Rules do
  def spin_configuration(_type) do
    reelset = reelsets()

    reels =
      [:basic0, :basic1, :basic2]
      |> Enum.map(fn reel -> reelset[reel] end)
      |> Enum.zip(reelarea())

    %Slot.SpinConfiguration{reels: reels, paytable: paytable()}
  end

  defp reelarea() do
    [
      [{0, 0}, {0, 1}, {0, 2}],
      [{1, 0}, {1, 1}, {1, 2}],
      [{2, 0}, {2, 1}, {2, 2}]
    ]
  end

  def lines() do
    [
      line0: [{0, 0}, {1, 0}, {2, 0}],
      line1: [{0, 1}, {1, 1}, {2, 1}],
      line2: [{0, 2}, {1, 2}, {2, 2}]
    ]
  end

  defp random_reel() do
    Enum.zip([:wild, :sym1, :sym2, :sym3, :sym4, :sym5, :sym6, :sym7, :sym8, :sym9], [10, 20, 25, 30, 40, 50, 50, 50, 50, 50])
    |> Enum.map(fn {sym, count} -> Enum.take(Stream.cycle([sym]), count) end)
    |> Enum.concat()
    |> Enum.shuffle()
  end

  def reelsets() do
    [:basic0, :basic1, :basic2, :basic3, :basic4, :freespin0, :freespin1, :freespin2, :freespin3, :freespin4]
    |> Enum.map(fn reel -> {reel, random_reel()} end)
  end

  def paytable() do
    %{
      [:wild, :wild, :wild] => 10,
      [:sym1, :sym1, :sym1] => 10,
      [:sym2, :sym2, :sym2] => 6,
      [:sym3, :sym3, :sym3] => 4,
      [:sym4, :sym4, :sym4] => 3,
      [:sym5, :sym5, :sym5] => 2,
      [:sym6, :sym6, :sym6] => 1
    }
  end
end
