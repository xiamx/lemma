defmodule StringPatternMatching do
  def hash_of(i) do
    (:crypto.hash(:sha, "#{i}") |> Base.encode16)
  end
  defmacro generate_lemma(num) do
    for i <- 0..num do
      root = hash_of(i)
      quote do
        def lemma(unquote(root) <> suffix) do
          unquote(root) <> case suffix do
            "s" -> ""
            "ed" -> ""
            "ing" -> ""
          end
        end
      end
    end
  end

end

defmodule LemmaTen do
  require StringPatternMatching
  StringPatternMatching.generate_lemma(10)
end

IO.puts "lemma10 compiled"

defmodule Lemma100 do
  require StringPatternMatching
  StringPatternMatching.generate_lemma(100)
end

IO.puts "lemma100 compiled"

defmodule Lemma1000 do
  require StringPatternMatching
  StringPatternMatching.generate_lemma(1000)
end

IO.puts "lemma1000 compiled"

# defmodule Lemma10000 do
#   require StringPatternMatching
#   StringPatternMatching.generate_lemma(10000)
# end

# IO.puts "lemma10000 compiled"

# defmodule Lemma100000 do
#   require StringPatternMatching
#   StringPatternMatching.generate_lemma(100000)
# end

# defmodule Lemma1000000 do
#   require StringPatternMatching
#   StringPatternMatching.generate_lemma(1000000)
# end


Benchee.run(%{
  "10 canonical words" => fn -> LemmaTen.lemma(StringPatternMatching.hash_of(5) <> "s") end,
  "100 canonical words" => fn -> Lemma100.lemma(StringPatternMatching.hash_of(50) <> "s") end,
  "1000 canonical words" => fn -> Lemma1000.lemma(StringPatternMatching.hash_of(900) <> "s") end,
  # "10000 canonical words" => fn -> Lemma10000.lemma(StringPatternMatching.hash_of(5000) <> "s") end,
  # "100000 canonical words" => fn -> Lemma1000.lemma(StringPatternMatching.hash_of(50000) <> "s") end,
  # "1000000 canonical words" => fn -> Lemma10000.lemma(StringPatternMatching.hash_of(500000) <> "s") end,
})