defmodule LemmaTest do
  use ExUnit.Case
  doctest Lemma

  setup_all _context do
    [fst: Lemma.new(:en)]
  end

  test "simple scenario", context do
    assert {:ok, "play"} == context[:fst] |> Lemma.parse("plays")
  end

  test "lemmatize multiple words", context do
    words = ["plays", "running", "better", "cats"]
    result = context[:fst] |> Lemma.parse(words)
    assert is_list(result)
    assert length(result) == length(words)

    # Check that each result is one of the valid return types
    Enum.each(result, fn item ->
      case item do
        {:ok, _lemma} -> assert true
        {:ambigious, lemmas} when is_list(lemmas) -> assert true
        {:error, _reason} -> assert true
        _ -> assert false, "Unexpected return format: #{inspect(item)}"
      end
    end)
  end

  test "handle common English words", context do
    test_cases = [
      # Test cases that should work
      {"plays", :ok},
      {"cats", :ok},
      # Test cases that might be ambiguous
      {"runs", :ambigious},
      {"running", :ambigious},
      {"better", :ambigious}
    ]

    Enum.each(test_cases, fn {word, expected_type} ->
      result = context[:fst] |> Lemma.parse(word)

      case expected_type do
        :ok ->
          assert match?({:ok, _}, result),
                 "Expected #{word} to return {:ok, lemma}, got #{inspect(result)}"

        :ambigious ->
          assert match?({:ambigious, _}, result),
                 "Expected #{word} to return {:ambigious, lemmas}, got #{inspect(result)}"
      end
    end)
  end

  test "handle unknown words", context do
    result = context[:fst] |> Lemma.parse("unknownword123")
    assert match?({:error, _}, result)
  end
end
