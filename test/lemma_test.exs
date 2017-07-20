defmodule LemmaTest do
  use ExUnit.Case
  use GenStateMachine
  doctest Lemma

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "simple scenario" do
    assert {:ok, "play"} == Lemma.Parser.parse("plays")
  end
end
