parser = Lemma.Parser.new :en

words = [
  "The", "history", "of", "NLP", "generally",
  "started", "in", "the", "1950s", "although",
  "work", "can", "be", "found", "from", "earlier",
  "periods", "In", "1950", "Alan", "Turing",
  "published", "an", "article", "titled", "Computing",
  "Machinery", "and", "Intelligence", "which",
  "proposed", "what", "is", "now", "called", "the",
  "Turing", "test", "as", "a", "criterion", "of",
  "intelligence"
]

words = words |> List.duplicate(10) |> List.flatten

IO.puts "Benchmark using #{Enum.count words} fixture words"

Benchee.run(%{
  "Lemmatize input sequential" => fn () ->
    Enum.map(words, &(Lemma.Parser.parse(parser, &1)))
  end,
  "Lemmatize input parallel" => fn () ->
    Lemma.Parser.parse(parser, words)
  end,
})