# SPDX-License-Identifier: PMPL-1.0-or-later
# justfile for poly-iac-lsp

# Default recipe: show available commands
default:
    @just --list

# Install dependencies
setup:
    mix deps.get
    mix compile

# Run the LSP server
run:
    mix run --no-halt

# Run tests
test:
    mix test

# Run tests with coverage
test-coverage:
    mix coveralls.html
    @echo "Coverage report: cover/excoveralls.html"

# Run quality checks (format, credo, dialyzer)
quality:
    mix format --check-formatted
    mix credo --strict
    mix dialyzer

# Format code
format:
    mix format

# Run credo linter
lint:
    mix credo

# Run dialyzer type checker
dialyzer:
    mix dialyzer

# Build documentation
docs:
    mix docs
    @echo "Documentation: doc/index.html"

# Clean build artifacts
clean:
    mix clean
    rm -rf _build deps

# Build release
release:
    MIX_ENV=prod mix release

# Run all checks (format, credo, dialyzer, test)
check: format quality test

# Watch tests (requires mix_test_watch)
watch:
    mix test.watch
