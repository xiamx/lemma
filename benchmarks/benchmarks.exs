dyn_fst = Lemma.ParserDynamic.new
Benchee.run(%{
  "Compiled parser"    => fn -> Lemma.Parser.parse("plays") end,
  "Dynamic parser"    => fn -> Lemma.ParserDynamic.parse(dyn_fst, "plays") end,
})