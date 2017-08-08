defmodule Lemma.Parser do
  import Lemma.MorphParserGenerator
  use GenServer

  def new do
    fst = GenFST.new
    |> generate_rules(Lemma.En.IrregularAdjectives.rules)
    |> generate_rules(Lemma.En.IrregularAdverbs.rules)
    |> generate_rules(Lemma.En.IrregularNouns.rules)
    |> generate_rules(Lemma.En.IrregularVerbs.rules)
    |> generate_rules(Lemma.En.Verbs.all, Lemma.En.Rules.verbs)
    |> generate_rules(Lemma.En.Nouns.all, Lemma.En.Rules.nouns)
    |> generate_rules(Lemma.En.Adjectives.all, Lemma.En.Rules.adjs)
    {:ok, pid} = GenServer.start_link(__MODULE__, fst)
    pid
  end 

  def parse(pid, word) do
    GenServer.call(pid, {:parse, word})
  end

  def handle_call({:parse, word}, _from, fst) do
    parsed =  GenFST.parse(fst, word)
    {:reply, parsed, fst}
  end

end