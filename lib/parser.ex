defmodule Lemma.Parser do
  import Lemma.MorphParserGenerator
  use GenServer

  def new(:en) do
    parser = GenFST.new
    |> generate_rules(Lemma.En.IrregularAdjectives.rules)
    |> generate_rules(Lemma.En.IrregularAdverbs.rules)
    |> generate_rules(Lemma.En.IrregularNouns.rules)
    |> generate_rules(Lemma.En.IrregularVerbs.rules)
    |> generate_rules(Lemma.En.Verbs.all, Lemma.En.Rules.verbs)
    |> generate_rules(Lemma.En.Nouns.all, Lemma.En.Rules.nouns)
    |> generate_rules(Lemma.En.Adjectives.all, Lemma.En.Rules.adjs)
  end 

  def parse(parser, words = [w | ws]) do
    words
    |> Enum.map(&(Task.async(fn -> parse(parser, &1) end)))
    |> Enum.map(&Task.await/1)
  end

  def parse(parser, word) do
    parsed = GenFST.parse(parser, String.downcase(word))
  end
end