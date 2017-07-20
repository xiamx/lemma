defmodule Lemma.ParserDynamic do

  import Lemma.MorphParserGenerator

  def new do
    fst = GenFST.new
    |> generate_rules(Lemma.En.Verbs.all, Lemma.En.Rules.verbs)
    IO.puts("Rules generated")
    fst
  end

  def parse(fst, word) do
    GenFST.parse(fst, word)
  end

end