;; SPDX-License-Identifier: PMPL-1.0-or-later
;; ECOSYSTEM.scm - Project ecosystem position

(ecosystem
 (version "1.0")
 (name "poly-iac-lsp")
 (type "tool")
 (purpose "Language Server Protocol implementation for IDE integration of Infrastructure as Code tools (OpenTofu, Pulumi)")

 (position-in-ecosystem
  "Provides IDE/editor integration layer for Infrastructure as Code workflows. "
  "Sister project to poly-ssg-lsp (which serves static site generators). "
  "While poly-ssg-lsp handles SSG tooling, poly-iac-lsp handles IaC tooling. "
  "Both use the same Elixir + GenLSP architecture pattern for consistency.")

 (related-projects
  ((sibling "poly-ssg-lsp"
           "Sister project providing LSP for static site generators. Shares architectural patterns.")
   (sibling "poly-ssg-mcp"
           "MCP integration for AI assistants working with SSGs. Parallel tool for AI workflows.")
   (dependency "opentofu"
               "FOSS Terraform alternative. Primary IaC tool supported (MPL-2.0).")
   (dependency "pulumi"
               "Multi-language IaC tool. Secondary support (Apache-2.0, requires backend).")
   (consumer "vscode-poly-iac"
             "VSCode extension using this LSP (planned).")
   (inspiration "terraform-ls"
                "HashiCorp's Terraform language server. Architecture reference.")
   (inspiration "elixir-ls"
                "Elixir LSP server. GenLSP usage patterns.")))

 (what-this-is
  "A Language Server Protocol implementation in Elixir that provides IDE features "
  "(auto-completion, diagnostics, hover docs, commands) for Infrastructure as Code tools. "
  "Each IaC adapter runs as an isolated BEAM process with automatic fault recovery via "
  "supervision trees. Emphasizes FOSS-first policy by preferring OpenTofu over Terraform.")

 (what-this-is-not
  "This is not a replacement for terraform-ls or official tool LSPs. "
  "This is not an IaC tool itself - it provides IDE tooling for existing IaC tools. "
  "This is not a general-purpose Elixir LSP - it's specific to IaC workflows. "
  "This does not support Terraform (BSL license) - use OpenTofu instead."))
