defmodule Lemma.Parser do

  import Lemma.MorphParserGenerator

  @fst GenFST.new
  @fst generate_rules(@fst, Lemma.En.Verbs.all, Lemma.En.Rules.verbs)
  @fst generate_rules(@fst, Lemma.En.Nouns.all, Lemma.En.Rules.nouns)
  @fst generate_rules(@fst, Lemma.En.Adjectives.all, Lemma.En.Rules.adjs)
  IO.puts("Rules generated")

  def parse(word) do
    GenFST.parse(@fst, word)
  end

end