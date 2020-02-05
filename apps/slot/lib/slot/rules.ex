defmodule Slot.Rules do
  defp reelarea() do
    [
      [{0, 0}, {0, 1}, {0, 2}],
      [{1, 0}, {1, 1}, {1, 2}],
      [{2, 0}, {2, 1}, {2, 2}],
      [{3, 0}, {3, 1}, {3, 2}],
      [{4, 0}, {4, 1}, {4, 2}]
    ]
  end

  def spin_configuration(_type) do
    reelset = reelsets()

    reels =
      [:basic0, :basic1, :basic2, :basic3, :basic4]
      |> Enum.map(fn reel -> reelset[reel] end)
      |> Enum.zip(reelarea())

    %Slot.SpinConfiguration{reels: reels, paytable: paytable()}
  end

  def lines() do
    [
      line1: [{0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}],
      line2: [{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}],
      line3: [{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}],
      line4: [{0, 0}, {1, 1}, {2, 2}, {3, 1}, {4, 0}],
      line5: [{0, 2}, {1, 1}, {2, 0}, {3, 1}, {4, 2}],
      line6: [{0, 0}, {1, 0}, {2, 1}, {3, 0}, {4, 0}],
      line7: [{0, 2}, {1, 2}, {2, 1}, {3, 2}, {4, 2}],
      line8: [{0, 1}, {1, 2}, {2, 2}, {3, 2}, {4, 1}],
      line9: [{0, 1}, {1, 0}, {2, 0}, {3, 0}, {4, 1}],
      line10: [{0, 1}, {1, 1}, {2, 2}, {3, 1}, {4, 1}],
      line11: [{0, 1}, {1, 1}, {2, 0}, {3, 1}, {4, 1}],
      line12: [{0, 2}, {1, 1}, {2, 1}, {3, 1}, {4, 2}],
      line13: [{0, 0}, {1, 1}, {2, 1}, {3, 1}, {4, 0}],
      line14: [{0, 1}, {1, 0}, {2, 1}, {3, 0}, {4, 1}],
      line15: [{0, 1}, {1, 2}, {2, 1}, {3, 2}, {4, 1}],
      line16: [{0, 0}, {1, 1}, {2, 0}, {3, 1}, {4, 0}],
      line17: [{0, 2}, {1, 1}, {2, 2}, {3, 1}, {4, 2}],
      line18: [{0, 0}, {1, 2}, {2, 0}, {3, 2}, {4, 0}],
      line19: [{0, 2}, {1, 0}, {2, 2}, {3, 0}, {4, 2}],
      line20: [{0, 0}, {1, 0}, {2, 2}, {3, 0}, {4, 0}]
    ]
  end

  defp random_reel() do
    Enum.zip([:wild, :sym1, :sym2, :sym3, :sym4, :sym5, :sym6, :sym7, :sym8, :sym9], [30, 20, 25, 30, 40, 50, 50, 50, 50, 50])
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
      [:wild, :wild, :wild, :wild, :wild] => 100,
      [:wild, :wild, :wild, :wild] => 50,
      [:wild, :wild, :wild] => 10,
      [:sym1, :sym1, :sym1, :sym1, :sym1] => 100,
      [:sym1, :sym1, :sym1, :sym1] => 50,
      [:sym1, :sym1, :sym1] => 10,
      [:sym2, :sym2, :sym2, :sym2, :sym2] => 60,
      [:sym2, :sym2, :sym2, :sym2] => 30,
      [:sym2, :sym2, :sym2] => 6,
      [:sym3, :sym3, :sym3, :sym3, :sym3] => 40,
      [:sym3, :sym3, :sym3, :sym3] => 20,
      [:sym3, :sym3, :sym3] => 4,
      [:sym4, :sym4, :sym4, :sym4, :sym4] => 30,
      [:sym4, :sym4, :sym4, :sym4] => 15,
      [:sym4, :sym4, :sym4] => 3,
      [:sym5, :sym5, :sym5, :sym5, :sym5] => 20,
      [:sym5, :sym5, :sym5, :sym5] => 10,
      [:sym5, :sym5, :sym5] => 2,
      [:sym6, :sym6, :sym6, :sym6, :sym6] => 10,
      [:sym6, :sym6, :sym6, :sym6] => 5,
      [:sym6, :sym6, :sym6] => 1
    }
  end
end
