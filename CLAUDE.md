# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Overview

This is a nix-darwin configuration repository for managing a macOS system declaratively using Nix. The configuration defines system packages, Homebrew packages, system defaults, and user settings for the user "andreszambrano" on an Apple Silicon Mac.

## Project Structure

```
mac-config/
├── flake.nix              # Main system configuration
├── flake.lock             # Dependency lock file
├── home.nix               # Home Manager user configuration
├── .gitignore             # Git ignore patterns
├── CLAUDE.md              # This file
└── cli-config/            # Git submodule for CLI tools
    ├── packages/          # Individual package configurations
    │   ├── oh-my-posh.nix # Prompt theme configuration
    │   ├── git.nix        # Git configuration
    │   ├── zsh.nix        # Zsh shell configuration
    │   └── ...            # Other CLI tools
    ├── themes/            # Configuration themes (external files)
    ├── shells/            # Shell configurations and aliases
    ├── user/              # User-specific settings
    ├── home-manager/      # Home Manager integration
    └── nvim-config/       # Neovim configuration submodule
```

## Key Configuration Details

- **Configuration name**: "mini" (used in darwin-rebuild commands)
- **Target system**: aarch64-darwin (Apple Silicon)
- **Username**: andreszambrano
- **System packages**: Managed through Nix (minimal set)
- **GUI applications**: Managed through Homebrew casks
- **CLI tools**: Managed through Home Manager via cli-config
- **Shell**: Zsh with oh-my-posh prompt theme

## Common Commands

### System Management:
```bash
# Build and apply configuration
darwin-rebuild switch --flake .#mini

# Build without applying
darwin-rebuild build --flake .#mini

# Update all flake inputs
nix flake update

# Check configuration validity
nix flake check
```

### Submodule Management:
```bash
# Initialize submodules after cloning
git submodule update --init --recursive

# Update submodules to latest commits
git submodule update --remote

# Update flake inputs after submodule changes
nix flake update
```

## Architecture

### Flake Inputs:
- `nixpkgs`: Main package repository (nixpkgs-unstable)
- `nix-darwin`: macOS system configuration framework
- `nix-homebrew`: Integration for Homebrew package management
- `mac-app-util`: Utilities for macOS app integration
- `home-manager`: User environment and dotfiles management
- `cli-config`: Custom CLI tools and configurations (github:andreszb/cli-config)

### Configuration Layers:
1. **System Level** (`flake.nix`): Core system packages and Homebrew integration
2. **User Level** (`home.nix`): Home Manager configuration importing cli-config
3. **CLI Tools** (`cli-config/`): Modular package configurations with external themes

### Important Design Decisions:
- **Oh-my-posh theme**: Moved from inline Nix configuration to external JSON file for proper parsing
- **Home Manager integrations**: Disabled for oh-my-posh to avoid conflicts with manual shell initialization
- **Git ignore**: Excludes build artifacts, macOS system files, and IDE configurations

## Git Submodules

This repository includes git submodules for reference and quick local development:
- `cli-config/`: CLI tools and configurations (github:andreszb/cli-config)
  - Contains modular package configurations
  - Includes nested `nvim-config/` submodule for Neovim setup
  - Uses external theme files for complex configurations

### Submodule Workflow:
**Important**: While git submodules are present for local development and reference, the flake configuration uses GitHub repositories as inputs rather than local paths. This ensures reproducibility and proper dependency management in the Nix ecosystem.

The submodules serve as:
- Quick reference for configuration structure
- Local development environment for testing changes
- Easy access to update and modify configurations before pushing to GitHub

### Making Changes:
1. Make changes in the submodule directory (`cli-config/`)
2. Commit and push changes to the submodule's GitHub repository
3. Run `nix flake update` to update the lock file with the latest commits
4. Test the configuration with `darwin-rebuild build --flake .#mini`
5. Apply with `darwin-rebuild switch --flake .#mini`

### Troubleshooting:
- If oh-my-posh fails to load, check that theme files are properly formatted JSON
- For "bad pattern" errors, ensure Home Manager integrations are disabled for conflicting tools
- Use `git submodule status` to verify submodule states