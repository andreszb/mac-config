# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## System Overview

This is a nix-darwin configuration repository for managing a macOS system declaratively using Nix. The configuration defines system packages, Homebrew packages, system defaults, and user settings for the user "andreszambrano" on an Apple Silicon Mac.

## Key Configuration Structure

- `flake.nix`: Main configuration file defining the entire system setup
- `flake.lock`: Lock file pinning exact versions of all dependencies
- Configuration name: "mini" (used in darwin-rebuild commands)
- Target system: aarch64-darwin (Apple Silicon)
- Username: andreszambrano

## Common Commands

### Build and apply configuration:
```bash
darwin-rebuild switch --flake .#mini
```

### Build without applying:
```bash
darwin-rebuild build --flake .#mini
```

### Update flake inputs:
```bash
nix flake update
```

### Check configuration:
```bash
nix flake check
```

## Architecture

The flake uses several key inputs:
- `nixpkgs`: Main package repository (nixpkgs-unstable)
- `nix-darwin`: macOS system configuration framework
- `nix-homebrew`: Integration for Homebrew package management
- `mac-app-util`: Utilities for macOS app integration
- `home-manager`: User environment and dotfiles management
- `cli-config`: Custom CLI tools and configurations (github:andreszb/cli-config)

The configuration is modular, combining nix-darwin base configuration with nix-homebrew, mac-app-util, and home-manager modules. System packages are managed through Nix, while GUI applications and Mac App Store apps are managed through Homebrew integration. User-specific configurations (like Git settings) are managed through Home Manager in `home.nix`.

## Git Submodules

This repository includes git submodules for reference and quick local development:
- `cli-config/`: CLI tools and configurations submodule

**Important**: While git submodules are present for local development and reference, the flake configuration uses GitHub repositories as inputs rather than local paths. This ensures reproducibility and proper dependency management in the Nix ecosystem. The submodules serve as:
- Quick reference for configuration structure
- Local development environment for testing changes
- Easy access to update and modify configurations before pushing to GitHub

When making changes to submodule configurations, remember to:
1. Make changes in the submodule directory
2. Commit and push changes to the submodule's GitHub repository
3. Run `nix flake update` to update the lock file with the latest commits