# Numa

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Hex.pm](https://img.shields.io/hexpm/v/numa.svg)](https://hex.pm/packages/numa)

Numa provides an easy way to define enum-like macros in Elixir.

It allows you to create named constants with associated values that can be used as compile-time macros.
You can pass a list of plain values or keyword pairs to automatically generate macros for your enums.
This is useful when you want efficient, readable constants without the overhead of runtime lookups.

## Features

- Define enums with mixed plain values (strings, atoms, integers) or explicit key-value pairs.
- Macro names are automatically prefixed with `_` to ensure valid names, even if keys start with digits.
- Provides helper functions to retrieve all enum keys, values, or key-value pairs.
- Validates input and raises clear errors for invalid enum entries.

## Installation

Add `numa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:numa, "~> 0.1.0"}
  ]
end
```

Then fetch dependencies:

```bash
mix deps.get
```

## Usage

### Defining simple enums

When names and values are the same:

```elixir
defmodule MyEnums do
  use Numa, ["FULL", "1M"]
end

MyEnums._FULL()  # => "FULL"
MyEnums._1M()    # => "1M"
```

### Defining enums with explicit names and values

```elixir
defmodule MyEnums do
  use Numa, [M3: "3m", MINI: "MINI"]
end

MyEnums._M3()    # => "3m"
MyEnums._MINI()  # => "MINI"
```

### Mixed enums and helper functions

```elixir
defmodule MyEnums do
  use Numa, ["FULL", "1M", M3: "3m", mini: "MINI"]
end

MyEnums._FULL()    # => "FULL"
MyEnums._1M()      # => "1M"
MyEnums._M3()      # => "3m"
MyEnums._mini()    # => "MINI"

MyEnums.values()   # => ["FULL", "1M", "3m", "MINI"]
MyEnums.keys()     # => [:_FULL, :_1M, :_M3, :_mini]
MyEnums.all()      # => [{:_FULL, "FULL"}, {:_1M, "1M"}, {:_M3, "3m"}, {:_mini, "MINI"}]
```

### Dynamic enum list

You can also pass a function returning a list:

```elixir
defmodule MyEnums do
  use Numa, fn -> ["A", "B", "C"] end
end

MyEnums._A()   # => "A"
```

## Error handling

Invalid input raises clear errors:

```elixir
defmodule InvalidEnums do
  use Numa, [%{}]  # Raises ArgumentError: Invalid Numa list value: %{}, expected type: atom, binary or integer
end
```

## Documentation

Documentation is generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm/numa).

---

Created and maintained by [Centib](https://github.com/Centib).