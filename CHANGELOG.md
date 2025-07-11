# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),  
and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.1.0] - 2025-07-11

### Added

- Initial release of Numa — a tiny Elixir library for defining enum-like macros with helpers.
- Support for defining enums using plain values (`["A", "B"]`) or keyword pairs (`[A: "alpha", B: "beta"]`).
- Automatic macro name generation with `_` prefix.
- Helper functions: `keys/0`, `values/0`, and `all/0` for inspecting enums.
- Validation of enum input with clear error messages.
- Support for passing a function to generate enum values dynamically.
