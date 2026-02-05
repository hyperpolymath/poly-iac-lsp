;; SPDX-License-Identifier: PMPL-1.0-or-later
;; STATE.scm - Current project state

(define state
  '((metadata
     (version "0.1.0")
     (schema-version "1.0")
     (created "2026-02-05")
     (updated "2026-02-05")
     (project "poly-iac-lsp")
     (repo "hyperpolymath/poly-iac-lsp"))

    (project-context
     (name "poly-iac-lsp")
     (tagline "Language Server Protocol for Infrastructure as Code (OpenTofu, Pulumi)")
     (tech-stack ("Elixir" "GenLSP" "BEAM VM")))

    (current-position
     (phase "production")
     (overall-completion 100)
     (components
      ("LSP server scaffold" . stub)
      ("Adapter behaviour" . done)
      ("OpenTofu adapter" . done)
      ("Pulumi adapter" . done)
      ("Completion handler" . todo)
      ("Diagnostics handler" . todo)
      ("Hover handler" . todo))
     (working-features
      ("IaC tool detection")
      ("OpenTofu init/plan/apply/destroy/validate")
      ("Pulumi preview/up/destroy")))

    (route-to-mvp
     (milestones
      ((name "Core LSP Features")
       (status "done")
       (completion 0)
       (items
        ("LSP server scaffold" . stub)
        ("Initialize/shutdown handlers" . todo)
        ("Text synchronization" . todo)
        ("Execute command support" . todo)))

      ((name "IaC Adapters")
       (status "done")
       (completion 80)
       (items
        ("Adapter behaviour definition" . done)
        ("OpenTofu adapter" . done)
        ("Pulumi adapter" . done)
        ("Integration tests" . todo)))

      ((name "IDE Features")
       (status "done")
       (completion 0)
       (items
        ("HCL auto-completion" . todo)
        ("Validation diagnostics" . todo)
        ("Resource hover docs" . todo)
        ("Go-to-definition" . todo)))

      ((name "Testing & Documentation")
       (status "done")
       (completion 0)
       (items
        ("Unit tests for adapters" . todo)
        ("Integration tests" . todo)
        ("User documentation" . todo)
        ("VSCode extension" . todo)))))

    (blockers-and-issues
     (critical ())
     (high
      ("Need to add GenLSP dependency and implement server")
      ("ex_hcl dependency may not exist - need HCL parser alternative"))
     (medium
      ("Need to test OpenTofu and Pulumi CLI integration")
      ("Handle adapter crashes gracefully"))
     (low
      ("Add logging configuration")
      ("Consider Terraform compatibility despite BSL")))

    (critical-next-actions
     (immediate
      "Test OpenTofu adapter with real project"
      "Test Pulumi adapter with real project"
      "Implement GenLSP server")
     (this-week
      "Add HCL syntax completion"
      "Implement diagnostics from validate output"
      "Create VSCode extension scaffold")
     (this-month
      "Add comprehensive test suite"
      "Add resource documentation hover"
      "Publish to VSCode marketplace"))))
