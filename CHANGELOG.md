# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project structure
- OpenTofu adapter with init/plan/apply/destroy/validate support
- Pulumi adapter with preview/up/destroy support
- Adapter behaviour defining IaC tool interface
- VSCode extension scaffold
- Checkpoint files (STATE.scm, META.scm, ECOSYSTEM.scm)

### Design Decisions
- FOSS-first policy: OpenTofu over Terraform (MPL-2.0 vs BSL)
- Elixir + GenLSP architecture following poly-ssg-lsp pattern
- Isolated GenServer processes for fault tolerance

## [0.1.0] - TBD

### Planned
- Full LSP server implementation with GenLSP
- HCL syntax auto-completion
- Validation diagnostics
- Resource hover documentation
- VSCode extension with IaC commands
