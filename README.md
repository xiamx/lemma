# <img src="http://cs.mcgill.ca/~mxia3/images/lemma.png" alt="Lemma">

[![Build Status](https://travis-ci.org/xiamx/lemma.svg?branch=master)](https://travis-ci.org/xiamx/lemma)
[![Hex.pm](https://img.shields.io/hexpm/v/lemma.svg)](https://hex.pm/packages/lemma)
[![license](https://img.shields.io/github/license/xiamx/lemma.svg)](https://github.com/xiamx/lemma/blob/master/LICENSE)


A Morphological Parser (Analyser) / Lemmatizer written in Elixir. It is implemented using a textbook classic method relying in an abstraction called [Finite State Transducer](https://github.com/xiamx/gen_fst). 

**What are morphological parsing and lemmatization?**

> For grammatical reasons, documents are going to use different forms of a word, such as organize, organizes, and organizing. Additionally, there are families of derivationally related words with similar meanings, such as democracy, democratic, and democratization. In many situations, it seems as if it would be useful for a search for one of these words to return documents that contain another word in the set.
> <br/> The goal of both stemming and lemmatization is to reduce inflectional forms and sometimes derivationally related forms of a word to a common base form. For instance:
> <br/><br/>am, are, is ⇒ be 
> <br/>car, cars, car's, cars' ⇒ car
> <br/><br/>The result of this mapping of text will be something like:
> <br/>_the boy's cars are different colors_ ⇒
> the boy car be differ color. 
> <br/> -- [Stanford NLP Group](https://nlp.stanford.edu/IR-book/html/htmledition/stemming-and-lemmatization-1.html)

**Not for production use, this library is neither cpu nor memory efficient**

## Example Usage

```elixir
# Initialize a new morphological parser for English
parser = Lemma.new :en
assert {:ok, "play"} == parser |> Lemma.parse("plays")
```

Documentation can be found at [https://hexdocs.pm/lemma](https://hexdocs.pm/lemma).
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `lemma` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:lemma, "~> 0.1.0"}]
end
```

## Benchmarking

### Lemmatize a paragraph of words

A simple benchmarking script is provided to test the performance of performing lemmatization on a paragraph of words. The script can be invoked with `mix run benchmarks/lemmatizing.exs`

#### Sample output

```
Benchmark using 430 fixture words
Operating System: Windows
CPU Information: Intel(R) Core(TM) i5-5300U CPU @ 2.30GHz
Number of Available Cores: 4
Available memory: 12.753915904 GB
Elixir 1.5.0
Erlang 19.2
Benchmark suite executing with the following configuration:
warmup: 2.00 s
time: 5.00 s
parallel: 1
inputs: none specified
Estimated total run time: 7.00 s


Benchmarking Lemmatize input sequential...

Name                                 ips        average  deviation         median
Lemmatize input sequential          4.31      232.14 ms    68.17%      110.00 ms
```

### Compile-time vs Runtime parser

To evaluate the difference between building the parser at compile time vs. building the parser at runtime, we have another benchmarking script.
The script can be invoked with `mix run benchmarks/runtime_vs_compiletime.exs`

#### Sample output

```
Operating System: Windows
CPU Information: Intel(R) Core(TM) i5-5300U CPU @ 2.30GHz
Number of Available Cores: 4
Available memory: 12.753915904 GB
Elixir 1.5.0
Erlang 19.2
Benchmark suite executing with the following configuration:
warmup: 2.00 s
time: 5.00 s
parallel: 1
inputs: none specified
Estimated total run time: 14.00 s


Benchmarking Compiled parser...
Benchmarking Dynamic parser...

Name                      ips        average  deviation         median
Compiled parser       15.91 K       62.86 us   123.32%         0.0 us
Dynamic parser         3.80 K      262.91 us   118.03%      160.00 us

Comparison:
Compiled parser       15.91 K
Dynamic parser         3.80 K - 4.18x slower
```


