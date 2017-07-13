defmodule LemmaTest do
  use ExUnit.Case
  use GenStateMachine
  doctest Lemma

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "simple scenario" do
    {:ok, pid} = Lemma.start_link
    assert "play^s" == Lemma.read(pid, "plays")
    {:ok, pid} = Lemma.start_link
    assert "act" == Lemma.read(pid, "act")
  end
end
