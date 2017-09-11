defmodule LemmaTest do
  use ExUnit.Case
  use GenStateMachine
  doctest Lemma

  setup_all context do
    [fst: Lemma.Parser.new :en]
  end

  test "simple scenario", context do
    assert {:ok, "play"} == context[:fst] |> Lemma.Parser.parse("plays")
  end
end
