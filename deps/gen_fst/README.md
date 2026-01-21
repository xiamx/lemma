# ![Elixir](https://hexdocs.pm/ex_unit/assets/logo.png) GenFST

[![Build Status](https://travis-ci.org/xiamx/gen_fst.svg?branch=master)](https://travis-ci.org/xiamx/gen_fst)
[![Hex.pm](https://img.shields.io/hexpm/v/gen_fst.svg)](https://hex.pm/packages/gen_fst)
[![license](https://img.shields.io/github/license/xiamx/gen_fst.svg)](https://github.com/xiamx/gen_fst/blob/master/LICENSE)

GenFST implements a generic finite state transducer with
customizable rules expressed in a DSL.

A finite-state transducer (FST) is a finite-state machine
with two memory tapes, following the terminology for Turing
machines: an input tape and an output tape.

A FST will read a set of strings on the input tape and
generates a set of relations on the output tape. An FST
can be thought of as a translator or relater between strings in a set.

In morphological parsing, an example would be inputting a string of letters
into the FST, the FST would then output a string of
[morphemes](https://en.wikipedia.org/wiki/Morphemes).

## Example

Here we implement a simple morphological parser for English language. This
morphological parser recognize different inflectional morphology of the verbs.

```elixir
fst = GenFST.new
|> GenFST.rule(["play", {"s", "^s"}])
|> GenFST.rule(["act", {"s", "^s"}])
|> GenFST.rule(["act", {"ed", "^ed"}])
|> GenFST.rule(["act", {"ing", ""}])

assert "play^s" == fst |> GenFST.parse("plays")
```

For example if we pass the third-person singluar tense of the verb _act_,
`GenFST.parse(fst, "acts")`, the morphological parser will output
`"act^s"`. The semantic of rule definition is given at [`rule/2`](https://hexdocs.pm/gen_fst/GenFST.html#rule/2).

## Installation

The package can be installed by adding `gen_fst` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [{:gen_fst, "~> 0.4.0"}]
end
```

## Documentation

The docs for this project can be found at [https://hexdocs.pm/gen_fst](https://hexdocs.pm/gen_fst).
