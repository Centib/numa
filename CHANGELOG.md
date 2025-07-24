# Changelog

## v0.1.1 (2025-07-24)

- Documentation improvements in `README.md`
- Updated project logo

## v0.1.0 (2025-07-11)

- Initial release of Numa — a tiny Elixir library for defining enum-like macros with helpers.
- Support for defining enums using plain values (`["A", "B"]`) or keyword pairs (`[A: "alpha", B: "beta"]`).
- Automatic macro name generation with `_` prefix.
- Helper functions: `keys/0`, `values/0`, and `all/0` for inspecting enums.
- Validation of enum input with clear error messages.
- Support for passing a function to generate enum values dynamically.
