# Usage Guide

> Comprehensive guide for using poly-iac-lsp across VSCode, Neovim, and Emacs

## Table of Contents

- [VSCode Setup](#vscode-setup)
- [Neovim Setup](#neovim-setup)
- [Emacs Setup](#emacs-setup)
- [Configuration](#configuration)
- [Commands](#commands)
- [Troubleshooting](#troubleshooting)
- [Adapter-Specific Notes](#adapter-specific-notes)

## VSCode Setup

### Installation

1. **Install the LSP Server:**
   ```bash
   git clone https://github.com/hyperpolymath/poly-iac-lsp.git
   cd poly-iac-lsp
   ./install.sh
   ```

2. **Install VSCode Extension:**
   ```bash
   cd vscode-extension
   npm install
   npm run compile
   code --install-extension *.vsix
   ```

### Features

The VSCode extension provides:

- **Multi-Tool Support**: OpenTofu, Pulumi
- **HCL Completion**: Resources, variables, outputs
- **State Management**: View and manipulate state
- **Diagnostics**: Configuration errors, security issues
- **Hover Documentation**: Resource docs, variable info
- **Commands**: Plan, apply, destroy directly from editor

### Available Commands

Access via Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`):

- **IaC: Plan** - Generate execution plan
- **IaC: Apply** - Apply infrastructure changes
- **IaC: Destroy** - Destroy infrastructure
- **IaC: Show State** - View current state
- **IaC: Validate** - Validate configuration
- **IaC: Format** - Format IaC files
- **IaC: Graph** - Generate dependency graph

### Settings

Add to your workspace or user `settings.json`:

```json
{
  "lsp.serverPath": "/path/to/poly-iac-lsp",
  "lsp.trace.server": "verbose",
  "lsp.iac.tool": "auto",
  "lsp.iac.validateOnSave": true,
  "lsp.iac.autoFormat": true
}
```

## Neovim Setup

### Using nvim-lspconfig

Add to your Neovim configuration:

```lua
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Register poly-iac-lsp if not already defined
if not configs.poly_iac_lsp then
  configs.poly_iac_lsp = {
    default_config = {
      cmd = {'/path/to/poly-iac-lsp/_build/prod/rel/poly_iac_lsp/bin/poly_iac_lsp'},
      filetypes = {'hcl', 'terraform', 'tf', 'yaml'},
      root_dir = lspconfig.util.root_pattern(
        '.terraform',
        'main.tf',
        'terraform.tfvars',
        'Pulumi.yaml',
        'Pulumi.dev.yaml'
      ),
      settings = {
        iac = {
          tool = 'auto',
          validateOnSave = true,
          autoFormat = true
        }
      }
    }
  }
end

-- Setup the LSP
lspconfig.poly_iac_lsp.setup({
  on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- Custom commands
    vim.api.nvim_buf_create_user_command(bufnr, 'IacPlan', function()
      vim.lsp.buf.execute_command({command = 'iac.plan'})
    end, {})

    vim.api.nvim_buf_create_user_command(bufnr, 'IacApply', function()
      vim.lsp.buf.execute_command({command = 'iac.apply'})
    end, {})
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})
```

## Emacs Setup

### Using lsp-mode

Add to your Emacs configuration:

```elisp
(use-package lsp-mode
  :hook ((terraform-mode yaml-mode) . lsp)
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     '("/path/to/poly-iac-lsp/_build/prod/rel/poly_iac_lsp/bin/poly_iac_lsp"))
    :major-modes '(terraform-mode yaml-mode)
    :server-id 'poly-iac-lsp
    :initialization-options (lambda ()
                             '(:tool "auto"
                               :validateOnSave t)))))

;; Custom commands
(defun iac-plan ()
  "Generate execution plan."
  (interactive)
  (lsp-execute-command "iac.plan"))

(defun iac-apply ()
  "Apply infrastructure changes."
  (interactive)
  (lsp-execute-command "iac.apply"))

(define-key lsp-mode-map (kbd "C-c i p") 'iac-plan)
(define-key lsp-mode-map (kbd "C-c i a") 'iac-apply)
```

## Configuration

### Server Configuration

Create `.poly-iac-lsp.json` in your project root:

```json
{
  "iac": {
    "tool": "opentofu",
    "validateOnSave": true,
    "autoFormat": true,
    "backend": "local"
  },
  "opentofu": {
    "binaryPath": "/usr/bin/tofu",
    "version": "1.8+",
    "enableStateEncryption": true,
    "workspace": "default"
  },
  "pulumi": {
    "binaryPath": "/usr/bin/pulumi",
    "stack": "dev",
    "backend": "file://./state",
    "enableSecrets": true
  }
}
```

### Environment Variables

```bash
# OpenTofu
export TF_CLI_CONFIG_FILE=~/.tofurc
export TF_DATA_DIR=.terraform
export TF_WORKSPACE=default
export TF_LOG=INFO

# Pulumi
export PULUMI_HOME=~/.pulumi
export PULUMI_BACKEND_URL=file://./state
export PULUMI_CONFIG_PASSPHRASE=
export PULUMI_SKIP_UPDATE_CHECK=true
```

## Commands

### LSP Commands

#### iac.plan
Generate execution plan.

**Parameters:**
- `target` (optional): Specific resources to plan

**Returns:** Plan output

**Example (Neovim):**
```lua
vim.lsp.buf.execute_command({command = 'iac.plan'})
```

#### iac.apply
Apply infrastructure changes.

**Parameters:**
- `autoApprove` (optional): Skip confirmation

**Returns:** Apply status

#### iac.destroy
Destroy infrastructure.

**Parameters:**
- `target` (optional): Specific resources to destroy
- `force` (optional): Skip confirmation

**Returns:** Destroy status

#### iac.validate
Validate configuration.

**Parameters:** None

**Returns:** Validation errors/warnings

#### iac.state
View or manipulate state.

**Parameters:**
- `action`: State action (list, show, mv, rm)
- `resources` (optional): Target resources

**Returns:** State data

## Troubleshooting

### Tool Not Detected

**Symptoms:** LSP cannot find tofu or pulumi binary.

**Solutions:**

1. **Verify installation:**
   ```bash
   which tofu
   which pulumi
   ```

2. **Set binary path:**
   ```json
   {"lsp.iac.binaryPath": "/usr/local/bin/tofu"}
   ```

### State Lock Errors

**Symptoms:** "Error acquiring state lock" error.

**Solutions:**

1. **Check for existing lock:**
   ```bash
   # OpenTofu
   tofu force-unlock <LOCK_ID>

   # Pulumi
   pulumi cancel
   ```

2. **Verify backend configuration:**
   ```hcl
   terraform {
     backend "local" {
       path = "terraform.tfstate"
     }
   }
   ```

## Adapter-Specific Notes

### OpenTofu

**Detection:** `.terraform/` directory, `main.tf`, or `terraform.tfvars` files

**Features:**
- Full HCL syntax support
- Resource auto-completion
- State encryption
- Provider validation
- Module support

**Configuration:**
```json
{
  "adapters": {
    "opentofu": {
      "binaryPath": "/usr/bin/tofu",
      "enableStateEncryption": true,
      "workspace": "default",
      "backend": "local"
    }
  }
}
```

**Known Issues:**
- Remote backends may require additional authentication
- State file conflicts in team environments

### Pulumi

**Detection:** `Pulumi.yaml`, `Pulumi.<stack>.yaml` files

**Features:**
- Multi-language support (TypeScript, Python, Go, etc.)
- Secret management
- Stack management
- State backends
- Policy as code

**Configuration:**
```json
{
  "adapters": {
    "pulumi": {
      "binaryPath": "/usr/bin/pulumi",
      "stack": "dev",
      "backend": "file://./state",
      "enableSecrets": true
    }
  }
}
```

**Known Issues:**
- Language runtime required for full validation
- Cloud backends require authentication

## Additional Resources

- **GitHub Repository:** https://github.com/hyperpolymath/poly-iac-lsp
- **Issue Tracker:** https://github.com/hyperpolymath/poly-iac-lsp/issues
- **Examples:** See `examples/` directory for sample configurations

## License

PMPL-1.0-or-later
