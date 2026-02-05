# PolyIaC LSP VSCode Extension

Language Server Protocol extension for Infrastructure as Code tools.

## Features

- **Auto-completion**: HCL syntax, resource types, provider attributes
- **Diagnostics**: Validation errors, configuration issues
- **Hover Documentation**: Resource and provider documentation
- **Commands**: Init, plan, apply, validate, destroy

## Supported Tools

- **OpenTofu** (FOSS-first, preferred)
- **Pulumi** (requires backend setup)

## Requirements

- OpenTofu or Pulumi CLI installed
- Elixir runtime for LSP server

## Installation

TODO: Publish to VSCode marketplace

## Usage

1. Open a project containing `.tf` files (OpenTofu) or `Pulumi.yaml` (Pulumi)
2. The LSP server will start automatically
3. Use commands from the Command Palette (Ctrl+Shift+P)

## Commands

- `PolyIaC: Initialize Project` - Run init
- `PolyIaC: Plan Changes` - Generate execution plan
- `PolyIaC: Apply Changes` - Apply infrastructure changes
- `PolyIaC: Validate Configuration` - Validate config files
- `PolyIaC: Destroy Infrastructure` - Destroy managed resources

## Settings

- `poly-iac.tool`: IaC tool to use (auto, opentofu, pulumi)
- `poly-iac.opentofu.path`: Path to OpenTofu executable
- `poly-iac.pulumi.path`: Path to Pulumi executable

## License

PMPL-1.0-or-later
