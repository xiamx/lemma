# Statistex [![Build Status](https://travis-ci.org/bencheeorg/statistex.svg?branch=master)](https://travis-ci.org/bencheeorg/statistex) [![Coverage Status](https://coveralls.io/repos/github/bencheeorg/statistex/badge.svg?branch=master)](https://coveralls.io/github/bencheeorg/statistex?branch=master)

Statistex helps you do common statistics calculations and to explore a data set. It focusses on two things:

* providing you a `statistics/2` function that just **computes all statistics it knows for a data set**, reusing previously made calculations to not compute something again (for instance standard deviation needs the average, so it first computes the average and then passes it on): `Statistex.statistics(samples)`
* gives you the opportunity to **pass known values to functions** so that it doesn't need to compute more than it absolutely needs to: `Statistex.standard_deviation(samples, average: computed_average)`

## Installation

```elixir
def deps do
  [
    {:statistex, "~> 1.0"}
  ]
end
```

Supported elixir versions are 1.6+ (together with their respective erlang OTP versions aka 19+).

## Usage

Check out the documentation but here is a small overview:

```elixir
iex> samples = [1, 3.0, 2.35, 11.0, 1.37, 35, 5.5, 10, 0, 2.35]
# calculate all available statistics at once, efficiently reusing already calculated values
iex> Statistex.statistics(samples)
%Statistex{
  average: 7.156999999999999,
  frequency_distribution: %{
    0 => 1,
    1 => 1,
    10 => 1,
    35 => 1,
    1.37 => 1,
    2.35 => 2,
    3.0 => 1,
    5.5 => 1,
    11.0 => 1
  },
  maximum: 35,
  median: 2.675,
  minimum: 0,
  mode: 2.35,
  percentiles: %{50 => 2.675},
  sample_size: 10,
  standard_deviation: 10.47189577445799,
  standard_deviation_ratio: 1.46316833512058,
  total: 71.57,
  variance: 109.6606011111111
}
# or just calculate the value you need
iex> Statistex.average(samples)
7.156999999999999
# Calculate the value you want reusing values you already know
# (check the docs for what functions accepts what options)
iex> Statistex.average(samples, sample_size: 10)
7.156999999999999
# Most Statistex functions raise given an empty list as most functions don't make sense then.
# It is recommended that you manually handle the empty list case should that occur as your
# output is likely also very different from when you have statistics.
iex> Statistex.statistics([])
** (ArgumentError) Passed an empty list ([]) to calculate statistics from, please pass a list containing at least on number.
```

## Supported Statistics

For an up to date overview with explanations please check out the documentation.

Statistics currently supported:

* average
* frequency_distribution
* maximum
* median
* minimum
* mode
* percentiles
* sample_size
* standard_deviation
* standard_deviation_ratio
* total
* variance

## Alternatives

In elixir there are 2 notable other libraries that I'm aware of: [statistics](https://github.com/msharp/elixir-statistics) and [Numerix](https://github.com/safwank/Numerix).

Both include more functions than just for statistics: general math and more (drawing of random values for instance). They also have more statistics related functions as of this writing. So if you'e looking for something, that Statistex doesn't provide (yet) these are some of the first places I'd look.

Why would you still want to use Statistex?

* `statistics/2` is really nice when you're just exploring a data set or just want to have _everything_ at once
* when calling `statistics/2` Statistex **reuses previously calculated values** (_average_ for _standard_deviation_ for instance, or a sorted list of samples for some calculations) which makes for more efficient calculations. Statistex **extends that capability to you** so that you can pass pre calculated values as optional arguments.
* small and focussed on just statistics :)

We're naturally also looking to add more statistical functions as we go along, and pull requests are very welcome :)

## Performance

Statistex is written in pure elixir. C-extensions and friends would surely be faster. The goal of statistex is to be as fast possible in pure elixir while providing correct results. Hence, the focus on reusing previously calculated values and providing that ability to users.

## History

Statistex was extracted from [benchee](https://github.com/bencheeorg/benchee) and as such it powers benchees statistics calculations. Its great ancestor (if you will) was first conceived in [this commit](https://github.com/bencheeorg/benchee/commit/60fba66f927e0da20c4d16379dbf7274f77e63b5#diff-9d500e7ee9bd945a93b7172cca013d64).

## Contributing

Contributions to benchee are **very welcome**! Bug reports, documentation, spelling corrections, new statistics, bugfixes... all of those (and probably more) are much appreciated contributions!

Please respect the [Code of Conduct](//github.com/bencheeorg/statistex/blob/master/CODE_OF_CONDUCT.md).

You can also look directly at the [open issues](https://github.com/bencheeorg/statistex/issues).

A couple of (hopefully) helpful points:

* Feel free to ask for help and guidance on an issue/PR ("How can I implement this?", "How could I test this?", ...)
* Feel free to open early/not yet complete pull requests to get some early feedback
* When in doubt if something is a good idea open an issue first to discuss it
* In case I don't respond feel free to bump the issue/PR or ping me in other places

## Development

* `mix deps.get` to install dependencies
* `mix test` to run tests
* `mix dialyzer` to run dialyzer for type checking, might take a while on the first invocation (try building plts first with `mix dialyzer --plt`)
* `mix credo --strict` to find code style problems
