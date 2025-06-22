defmodule Lemma.MorphParserGenerator do
  @moduledoc """
  Functions for generating finite state transducer from a massive sets of rules.
  """

  defp filter_valid_words(words) do
    words
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
  end

  defp process_one_rule(fst, word, {suffix, morph} = _suffix_rule) do
    if String.ends_with?(word, suffix) do
      prefix = String.slice(word, 0, String.length(word) - String.length(suffix))
      GenFST.rule(fst, [prefix, {morph, suffix}])
    else
      fst
    end
  end

  @doc """
  Given a finite state transducer fst a list of rules, produce a new
  fst that incorporate these rules
  """
  def generate_rules(fst, rules_) do
    words_count = Enum.count(rules_)
    IO.puts("Generating rules for #{words_count} words")

    fst =
      Enum.reduce(Enum.with_index(rules_), fst, fn {r, i}, fst ->
        IO.write("\rProgress: #{i}/#{words_count} .. #{round(100 * i / words_count)}%")
        fst |> GenFST.rule(r)
      end)

    IO.write("\n")
    fst
  end

  @doc """
  Given a finite state transducer fst, a list of words and a list
  of suffix rules; produce a new fst that incorporate these suffix rules
  for each of the word.
  """
  def generate_rules(fst, words, suffix_rules) do
    words = filter_valid_words(words)
    words_count = Enum.count(words)
    IO.puts("Generating rules for #{words_count} words")

    fst =
      Enum.reduce(Enum.with_index(words), fst, fn {word, i}, fst ->
        IO.write("\rProgress: #{i + 1}/#{words_count} .. #{round(100 * i / words_count)}%")

        Enum.reduce(suffix_rules, fst, fn suffix_rule, fst ->
          process_one_rule(fst, word, suffix_rule)
        end)
      end)

    IO.write("\n")
    fst
  end
end
