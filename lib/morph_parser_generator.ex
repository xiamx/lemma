defmodule Lemma.MorphParserGenerator do
  def generate_rules(fst, words, suffix_rules) do
    words_count = Enum.count(words)
    IO.puts "Generating rules for #{words_count} words"
    Enum.reduce(Enum.with_index(words), fst, fn({word, i}, fst) -> 
      if word != "" do
        IO.write "\rProgress: #{i}/#{words_count} .. #{round(100*i/words_count)}%"
        Enum.reduce(suffix_rules, fst, fn({suffix, morph}, fst) -> 
          if String.match?(word, Regex.compile!(suffix <> "$")) do
            prefix = String.slice(word, 0, String.length(word) - String.length(suffix))
            GenFST.rule(fst, [prefix, {morph, suffix}])
          else
            fst
          end
        end)
      else
        fst
      end
    end)
  end
end