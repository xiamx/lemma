defmodule Lemma.MorphParserGenerator do

  defmacro generate_rules(words, suffix_rules) do
    quote location: :keep do
      for word <- unquote(words) do
        unless word == "" do
          for {suffix, morph} <- unquote(suffix_rules) do
            if String.match?(word, Regex.compile!(suffix <> "$")) do
              prefix = String.slice(word, 0, String.length(word) - String.length(suffix))
              rule [prefix, {morph, suffix}]
            end
          end
        end
      end
    end
  end
end