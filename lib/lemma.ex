defmodule Lemma do
  @moduledoc ~S"""
  A morphological parser (analyzer) / lemmatizer implemented with
  textbook standard method, using an abstraction called Finite State Transducer (FST).

  FST is implemented in [gen_fst](https://github.com/xiamx/gen_fst) package

  A parser can be initilized with desired language using `Lemma.new/1`.
  This initialized parser can be used to parse words with `Lemma.parse/2`

  ## Examples
  ```
  en_parser = Lemma.new :en
  #=> nil
  en_parser |> Lemma.parse("plays")
  #=> "play"
  ```

  ## About morphological parsing / lemmatization

  > For grammatical reasons, documents are going to use different forms of a word, such as organize, organizes, and organizing. Additionally, there are families of derivationally related words with similar meanings, such as democracy, democratic, and democratization. In many situations, it seems as if it would be useful for a search for one of these words to return documents that contain another word in the set.
  > <br/> The goal of both stemming and lemmatization is to reduce inflectional forms and sometimes derivationally related forms of a word to a common base form. For instance:
  > <br/><br/>am, are, is ⇒ be 
  > <br/>car, cars, car's, cars' ⇒ car
  > <br/><br/>The result of this mapping of text will be something like:
  > <br/>_the boy's cars are different colors_ ⇒
  > the boy car be differ color. 
  > <br/> -- [Stanford NLP Group](https://nlp.stanford.edu/IR-book/html/htmledition/stemming-and-lemmatization-1.html)

  """

  import Lemma.MorphParserGenerator

  @doc """
  Initialize a morphological parser for the given language.

  Only English (`:en`) is supported currently.
  """
  @spec new(atom) :: GenFST.fst
  def new(:en) do
    parser = GenFST.new
    |> generate_rules(Lemma.En.IrregularAdjectives.rules)
    |> generate_rules(Lemma.En.IrregularAdverbs.rules)
    |> generate_rules(Lemma.En.IrregularNouns.rules)
    |> generate_rules(Lemma.En.IrregularVerbs.rules)
    |> generate_rules(Lemma.En.Verbs.all, Lemma.En.Rules.verbs)
    |> generate_rules(Lemma.En.Nouns.all, Lemma.En.Rules.nouns)
    |> generate_rules(Lemma.En.Adjectives.all, Lemma.En.Rules.adjs)
  end 

  def new(l) do
    raise "language #{l} not supported"
  end

  @doc """
  Use the given parser to parse a word or a list of words.
  """
  @spec parse(GenFST.fst, String.t | [String.t]) :: String.t | [String.t]
  def parse(parser, [w | ws] = words) do
    Enum.map(words, &(parse(parser, &1)))
  end

  def parse(parser, word) do
    parsed = GenFST.parse(parser, String.downcase(word))
  end
end