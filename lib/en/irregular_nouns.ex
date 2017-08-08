defmodule Lemma.En.IrregularAdverbs do
  @rules [
    [{"best", "well"}],
    [{"better", "well"}],
    [{"deeper", "deeply"}],
    [{"farther", "far"}],
    [{"further", "far"}],
    [{"harder", "hard"}],
    [{"hardest", "hard"}],
  ]

  def rules do
    @rules
  end
end