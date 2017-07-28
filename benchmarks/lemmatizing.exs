fst = Lemma.Parser.new

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

IO.puts "Benchmark using #{Enum.count words} fixture words"

Benchee.run(%{
  "Lemmatize input" => fn () ->
    for word <- words do
      fst |> Lemma.Parser.parse(word)
    end
  end,
})