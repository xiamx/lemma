ExPrintf [![Build Status](https://secure.travis-ci.org/parroty/exprintf.png?branch=master "Build Status")](http://travis-ci.org/parroty/exprintf)
============
A printf / sprintf library for Elixir. It works as a wrapper for :io.format.

When learning Elixir / Erlang, remembering :io.format style is a little tough. This one can be used as syntax sugar, or an util to convert printf format to Elixir (Erlang) one.

# Examples

## Basic Usage

```elixir
defmodule Sample do
  import ExPrintf

  def test do
    printf("number = %d\n", [10])
    # -> number = 10
    IO.puts sprintf("string = %s", ["abc"])
    # -> string = abc

    format = parse_printf("format = %d %.2f\n")
    IO.inspect format
    # -> "format = ~w ~.2f\n"
    :io.format(format, [10, 10.153])
    # -> format = 10 10.15

    IO.puts :io_lib.format(format, [10, 10.153])
    # -> format = 10 10.15
  end
end

Sample.test
```

## Sample Execution

```
$ mix run sample.ex
number = 10
string = abc
"format = ~w ~.2f\n"
format = 10 10.15
```

## iex

```
$ git clone git@github.com:parroty/exprintf.git
$ cd exprintf
$ ./run_iex.sh
$ iex(1) -> parse_printf("%d")
"~w"
```

## Dynamo
The following hosts a sample dynamo application for the printf format conversion.

<a href="http://dynamo-exprintf.herokuapp.com/" target="_blank">http://dynamo-exprintf.herokuapp.com/</a>

## TODO
- Improve error checking
- Improve format support coverage
  - sprintf("%05d", [-10]) results in "00-10", instead of "-00010".
