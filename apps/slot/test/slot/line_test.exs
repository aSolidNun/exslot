defmodule Slot.LineTest do
  use ExUnit.Case

  test "start with wild sequence" do
    assert Slot.Line.sequence([:wild, :sym1, :sym2]) == [:wild, :sym1]
  end

  test "has wild sequence" do
    assert Slot.Line.sequence([:sym2, :wild, :sym2]) == [:sym2, :wild, :sym2]
  end

  test "only one in a row" do
    assert Slot.Line.sequence([:sym2, :sym1, :sym2]) == [:sym2]
  end

  test "replace wilds in a wild line" do
    assert Slot.Line.replace_wilds([:wild, :wild, :wild]) == [:sym1, :sym1, :sym1]
  end

  test "replace wilds in a non wild line" do
    assert Slot.Line.replace_wilds([:sym2, :sym2, :sym2]) == [:sym2, :sym2, :sym2]
  end

  test "replace wilds in a line with wilds" do
    assert Slot.Line.replace_wilds([:sym3, :wild, :sym3]) == [:sym3, :sym3, :sym3]
  end
end
