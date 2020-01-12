defmodule Slot.RandomTest do
    use ExUnit.Case, async: true

    setup do
        :rand.seed(:exsplus, {7, 13, 21})
    end 

    test "random sequence from reel" do
        assert Slot.Random.outcome(1..100, [{0, 1}], %{:mode => :any}) == [{{0, 1}, 77}]
    end

end