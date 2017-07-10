defmodule LemmaTest do
  use ExUnit.Case
  use GenStateMachine
  doctest Lemma

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "simple scenario" do
    {:ok, pid} = Lemma.start_link
    Lemma.read(pid, "plays")
    Lemma.get_output(pid) |> IO.inspect
  end
end
