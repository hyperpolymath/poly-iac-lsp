;; SPDX-License-Identifier: PMPL-1.0-or-later
;; META.scm - Meta-level project information

(define meta
  '((architecture-decisions
     ((adr-001
       (status "accepted")
       (date "2026-02-05")
       (context "Need to choose implementation language for IaC LSP server")
       (decision "Use Elixir with GenLSP framework, following poly-ssg-lsp architecture")
       (consequences
        "Pros: BEAM concurrency model perfect for isolated adapter processes. "
        "Hot code reload for fast development. Supervision trees for fault isolation. "
        "Code reuse from poly-ssg-lsp architecture. "
        "Cons: 1-2s startup time vs <100ms for Rust. 50MB memory vs 5MB for Rust. "
        "Trade-off accepted: startup time and memory overhead are acceptable for LSP servers."))

      (adr-002
       (status "accepted")
       (date "2026-02-05")
       (context "OpenTofu vs Terraform support decision")
       (decision "Support OpenTofu exclusively, NOT Terraform")
       (consequences
        "OpenTofu is FOSS (MPL-2.0) and drop-in compatible. "
        "Terraform moved to BSL (Business Source License) in 2023. "
        "Per hyperpolymath FOSS-first policy, we do not support proprietary licenses. "
        "Users can use 'tofu' commands which work with Terraform configs. "
        "Trade-off: Users on Terraform must switch to OpenTofu."))

      (adr-003
       (status "accepted")
       (date "2026-02-05")
       (context "Pulumi support despite requiring cloud backend")
       (decision "Support Pulumi with documentation about FOSS alternatives")
       (consequences
        "Pulumi is Apache-2.0 licensed (FOSS). "
        "However, it requires a backend (Pulumi Cloud or self-hosted). "
        "We support it but clearly mark OpenTofu as FOSS-first preferred. "
        "Documentation will guide users to self-hosted backends. "
        "Trade-off: Pragmatic support for popular tool while maintaining FOSS principles."))

      (adr-004
       (status "accepted")
       (date "2026-02-05")
       (context "Each IaC adapter could share process or run independently")
       (decision "Each adapter runs as its own GenServer under a supervision tree")
       (consequences
        "Crash in one adapter (e.g., Pulumi) doesn't affect others (e.g., OpenTofu). "
        "Supervisor automatically restarts crashed adapters. "
        "Parallel operations on multiple IaC projects automatically handled by BEAM. "
        "Trade-off: Higher memory usage (~1MB per adapter) but better fault isolation."))

      (adr-005
       (status "proposed")
       (date "2026-02-05")
       (context "HCL parsing for auto-completion and validation")
       (decision "Evaluate HCL parser options: ex_hcl, native Erlang port, or fallback to CLI")
       (consequences
        "ex_hcl may not be maintained or available. "
        "Native parsing provides better IDE experience but adds complexity. "
        "CLI fallback is reliable but slower. "
        "Will implement and test options to determine best approach."))))

    (development-practices
     (code-style
      "Follow Elixir community conventions. "
      "Use Credo for linting. "
      "Dialyzer for type checking. "
      "Format with mix format.")

     (security
      "SPDX headers on all files. "
      "No hardcoded credentials or API keys. "
      "Validate all file paths to prevent directory traversal. "
      "Sanitize IaC command arguments to prevent injection. "
      "Never auto-approve destructive operations (destroy, apply).")

     (testing
      "ExUnit for unit tests. "
      "Integration tests for LSP protocol. "
      "Mock IaC CLI commands for CI. "
      "Property-based tests for adapters.")

     (versioning
      "Semantic versioning. "
      "Changelog in CHANGELOG.md. "
      "Git tags for releases.")

     (documentation
      "ExDoc for API documentation. "
      "README.adoc for overview (AsciiDoc format). "
      "Inline @moduledoc and @doc. "
      "Examples in doctests. "
      "Emphasize FOSS-first policy in all docs.")

     (branching
      "Main branch protected. "
      "Feature branches for new work. "
      "PRs required for merges. "
      "CI checks must pass."))

    (design-rationale
     (foss-first
      "OpenTofu is preferred over Terraform due to MPL-2.0 vs BSL. "
      "Pulumi supported but marked as requiring backend setup. "
      "All documentation emphasizes FOSS alternatives. "
      "No proprietary tool support (Terraform, proprietary clouds).")

     (adapter-isolation
      "Each IaC tool runs in isolated GenServer process. "
      "Supervision tree ensures fault tolerance. "
      "BEAM scheduler handles concurrency automatically. "
      "No shared state between adapters prevents interference.")

     (lsp-protocol
      "GenLSP framework handles LSP protocol details. "
      "Focus on IaC-specific features, not protocol plumbing. "
      "Text synchronization for real-time diagnostics. "
      "Custom commands for IaC operations (init, plan, apply)."))))
