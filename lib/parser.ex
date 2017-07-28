defmodule Lemma.Parser do

  import Lemma.MorphParserGenerator

  def new do
    fst = GenFST.new
    |> generate_rules(Lemma.En.Verbs.all, Lemma.En.Rules.verbs)
    |> generate_rules(Lemma.En.Nouns.all, Lemma.En.Rules.nouns)
    |> generate_rules(Lemma.En.Adjectives.all, Lemma.En.Rules.adjs)
    IO.puts("Rules generated")
    fst
  end

  def parse(fst, word) do
    GenFST.parse(fst, word)
  end

end