defmodule LemmaTest do
  use ExUnit.Case
  use GenStateMachine
  doctest Lemma

  setup_all _context do
    [fst: Lemma.new :en]
  end

  test "simple scenario", context do
    assert {:ok, "play"} == context[:fst] |> Lemma.parse("plays")
  end
end
