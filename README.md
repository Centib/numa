# Numa

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Hex.pm](https://img.shields.io/hexpm/v/numa.svg)](https://hex.pm/packages/numa)
[![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/numa/)

> Lightweight compile-time symbolic constants for Elixir using macros.

**Numa** lets you define **enum-like constants** at compile-time using Elixir macros.

Inspired by traditional enums in languages like Java, Rust, or C#, Numa brings that concept to Elixir in a lightweight, idiomatic way. These are **not related to Elixir’s `Enum` module** — Numa is designed for defining named constants that expand at compile time, offering both performance and clarity.

## Features

* Define enums using plain values or key-value pairs — supports strings, atoms, and integers.
* Macro names are automatically prefixed with `_` to ensure valid names, even if keys start with digits.
* Provides helper functions to retrieve all enum keys, values, or key-value pairs.
* Validates input and raises clear errors for invalid enum entries.

## Installation

Add `numa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:numa, "~> 0.1.1"}
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
defmodule Enums do
  use Numa, ["FULL", "1M"]
end

Enums._FULL()  # => "FULL"
Enums._1M()    # => "1M"
```

### Defining enums with explicit names and values

```elixir
defmodule Enums do
  use Numa, [M3: "3m", MINI: "MINI"]
end

Enums._M3()    # => "3m"
Enums._MINI()  # => "MINI"
```

### Mixed enums and helper functions

```elixir
defmodule Enums do
  use Numa, ["FULL", "1M", M3: "3m", mini: "MINI"]
end

Enums._FULL()    # => "FULL"
Enums._1M()      # => "1M"
Enums._M3()      # => "3m"
Enums._mini()    # => "MINI"

Enums.values()   # => ["FULL", "1M", "3m", "MINI"]
Enums.keys()     # => [:_FULL, :_1M, :_M3, :_mini]
Enums.all()      # => [{:_FULL, "FULL"}, {:_1M, "1M"}, {:_M3, "3m"}, {:_mini, "MINI"}]
```

### Dynamic enum list

You can also pass a function returning a list:

```elixir
defmodule Enums do
  use Numa, fn -> ["A", "B", "C"] end
end

Enums._A()   # => "A"
```

## Error handling

Invalid input raises clear errors:

```elixir
defmodule InvalidEnums do
  use Numa, [%{}]  # Raises ArgumentError: Invalid Numa list value: %{}, expected type: atom, binary or integer
end
```

## Documentation

Full API docs available on [HexDocs](https://hexdocs.pm/numa).

## Contributing

Contributions are welcome via issues or pull requests.
Created and maintained by [Centib](https://github.com/Centib).

## License

Released under the [MIT License](LICENSE.md).
