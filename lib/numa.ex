defmodule Numa do
  @moduledoc """
  Provides enum-like macros for defining a set of named constants with associated values.

  This module allows you to easily define enums where each enum entry is represented as a macro
  that returns a fixed value. It supports a mixed list of values and keyword pairs for flexible usage.

  ## Features

  - Automatically creates macros named after enum keys (with a leading underscore).
  - Supports keys that are atoms, strings, or integers.
  - Supports values that can differ from the macro names.
  - Provides helper functions to retrieve all enum keys, values, or key-value pairs.
  - Validates inputs and raises clear errors on invalid types.

  ## Usage

  ### 1. Simple list of values

  When enum names and values are identical, provide a list of values (strings, atoms, or integers):

      use Numa, ["FULL", "1M"]

  This generates macros:

      defmacro _FULL(), do: "FULL"
      defmacro _1M(), do: "1M"   # Macro names are always prefixed with `_` to allow digits and avoid conflicts.

  ### 2. Keyword list with explicit keys and values

  When macro names should differ from values, pass a keyword list:

      use Numa, [M3: "3m", MINI: "MINI"]

  This generates macros:

      defmacro _M3(), do: "3m"
      defmacro _MINI(), do: "MINI"

  ### 3. Using a function returning a list

  You can also pass a zero-arity function that returns the enum list dynamically:

      use Numa, fn -> ["A", "B", "C"] end

  ## Generated helper functions

  - `values/0` — returns a list of all enum values.
  - `keys/0` — returns a list of all macro names (as atoms).
  - `all/0` — returns a list of `{key, value}` tuples representing all enums.

  ## Examples

      iex> defmodule MyEnums do
      ...>   use Numa, ["FULL", "1M", M3: "3m", mini: "MINI"]
      ...> end
      iex> MyEnums._FULL()
      "FULL"
      iex> MyEnums._1M()
      "1M"
      iex> MyEnums._M3()
      "3m"
      iex> MyEnums._mini()
      "MINI"
      iex> MyEnums.values()
      ["FULL", "1M", "3m", "MINI"]
      iex> MyEnums.keys()
      [:_FULL, :_1M, :_M3, :_mini]
      iex> MyEnums.all()
      [
        {:_FULL, "FULL"},
        {:_1M, "1M"},
        {:_M3, "3m"},
        {:_mini, "MINI"}
      ]

  ## Error handling

  Raises `ArgumentError` if the provided list contains unsupported types:

      iex> defmodule A do use Numa, [%{}] end
      ** (ArgumentError) Invalid Numa list value: %{}, expected type: atom, binary or integer

  ## Notes

  - Macro names are always prefixed with `_` to avoid conflicts and allow starting names with digits.
  - Keys in keyword lists must be atoms.
  - Values can be atoms, strings, or integers.

  """

  defmacro __using__(values) do
    quote bind_quoted: [values: values] do
      underscore_string = fn
        v when is_binary(v) -> String.to_atom("_" <> v)
      end

      underscore = fn
        v when is_binary(v) -> v |> underscore_string.()
        v when is_atom(v) -> v |> Atom.to_string() |> underscore_string.()
        v when is_integer(v) -> v |> Integer.to_string() |> underscore_string.()
      end

      values = if is_function(values), do: values.(), else: values

      kv =
        if is_list(values) do
          Enum.map(values, fn
            {k, v} when is_atom(k) ->
              {underscore.(k), v}

            {k, _} ->
              raise ArgumentError,
                    "Invalid Numa keyword: #{inspect(k)}, expected type: atom"

            v when is_atom(v) or is_binary(v) or is_integer(v) ->
              {underscore.(v), v}

            v ->
              raise ArgumentError,
                    "Invalid Numa list value: #{inspect(v)}, expected type: atom, binary or integer"
          end)
        else
          raise ArgumentError, "use Numa expects a list or keyword list"
        end

      for {key, val} <- kv do
        def unquote(key)(), do: unquote(val)
      end

      def values(), do: unquote(Enum.map(kv, &elem(&1, 1)))
      def keys(), do: unquote(Enum.map(kv, &elem(&1, 0)))
      def all(), do: unquote(kv)
    end
  end
end
