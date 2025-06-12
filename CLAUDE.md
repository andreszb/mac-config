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

The configuration is modular, combining nix-darwin base configuration with nix-homebrew, mac-app-util, and home-manager modules. System packages are managed through Nix, while GUI applications and Mac App Store apps are managed through Homebrew integration. User-specific configurations (like Git settings) are managed through Home Manager in `home.nix`.