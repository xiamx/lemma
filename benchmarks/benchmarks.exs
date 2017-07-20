Benchee.run(%{
  "lemmatize English verb"    => fn -> Lemma.Parser.parse("plays") end,
})