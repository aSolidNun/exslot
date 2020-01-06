defmodule Slot.Rules do
    def spin_configuration() do
        reelset = reelsets()
        reels = [:b0, :b1, :b2]

        |> Enum.map(fn reel -> reelset[reel] end)
        |> Enum.zip(reelarea())
    
        %Slot.SpinConfiguration{reels: reels, paytable: paytable()}
    end

    defp reelarea() do
        [
            [{0,0}, {0,1}, {0,2}],
            [{1,0}, {1,1}, {1,2}], 
            [{2,0}, {2,1}, {2,2}]
        ]       
    end

    def lines() do
        [
            line0: [{0, 0}, {1, 0}, {2, 0}],
            line1: [{0, 1}, {1, 1}, {2, 1}],
            line2: [{0, 2}, {1, 2}, {2, 2}]
        ]
            
    end 

    def reelsets() do
        %{
          :b0 => [:sym3, :wild, :sym2, :sym5, :sym3, :sym4, :wild, :sym1, :sym5, :wild,
                  :sym2, :sym3, :sym2, :sym4, :sym4, :sym5, :wild, :sym1, :sym1, :sym1],
          :b1 => [:sym5, :sym5, :sym4, :sym3, :wild, :wild, :wild, :sym3, :wild, :sym1,
                  :sym5,:sym4, :sym2, :sym3, :sym1, :sym1, :sym2, :sym1, :sym4, :sym2],
          :b2 => [:sym1, :sym3, :sym1, :sym2, :sym2, :sym3, :sym1, :sym5, :wild, :sym4,
                  :wild, :sym5, :sym4, :sym1, :sym3, :sym5, :sym4, :wild, :sym2, :wild]
        }
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