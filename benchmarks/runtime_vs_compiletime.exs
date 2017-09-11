defmodule Lemma.Benchmark.ParserDynamic do
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

defmodule Lemma.Benchmark.Parser do
  import Lemma.MorphParserGenerator
  @fst GenFST.new
  @fst generate_rules(@fst, Lemma.En.Verbs.all, Lemma.En.Rules.verbs)
  IO.puts("Rules generated")
  def parse(word) do
    GenFST.parse(@fst, word)
  end
end

dyn_fst = Lemma.Benchmark.ParserDynamic.new
Benchee.run(%{
  "Compiled parser"    => fn -> Lemma.Benchmark.Parser.parse("plays") end,
  "Dynamic parser"    => fn -> Lemma.Benchmark.ParserDynamic.parse(dyn_fst, "plays") end,
})