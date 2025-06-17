# macOS Configuration with Nix Darwin

A declarative macOS system configuration using Nix Darwin, Home Manager, and modular CLI tools.

## 🚀 Quick Start

```bash
# Clone with submodules
git clone --recursive https://github.com/andreszb/mac-config.git
cd mac-config

# Build and apply configuration
sudo darwin-rebuild switch --flake .#mini
```

## 📋 What's Included

### System Management
- **Nix Darwin**: Declarative macOS system configuration
- **Home Manager**: User environment and dotfiles management
- **Homebrew Integration**: GUI applications and Mac App Store apps

### CLI Tools & Shell
- **Zsh** with oh-my-posh prompt theme
- **Modern CLI replacements**: `eza`, `bat`, `fd`, `ripgrep`, `btop`
- **Development tools**: `git`, `delta`, `fzf`, `direnv`, `jq`
- **File management**: `yazi`, `zoxide`

### Applications (Homebrew)
- **Productivity**: 1Password, Spark, TickTick
- **Development**: Various tools and utilities
- **System**: Logi Options+, Amethyst, BetterDisplay

## 🏗️ Architecture

```
System Level (Nix Darwin)
├── Core system packages
├── Homebrew integration
└── System defaults

User Level (Home Manager)  
├── CLI tools via cli-config
├── Shell configuration
└── Dotfiles management

CLI Config (Submodule)
├── Modular package configs
├── Theme files
└── Shell aliases
```

## 📁 Project Structure

```
mac-config/
├── flake.nix              # Main system configuration
├── home.nix               # Home Manager setup
├── .gitignore             # Ignore build artifacts
└── cli-config/            # CLI tools submodule
    ├── packages/          # Individual tool configs
    ├── themes/            # External theme files
    ├── shells/            # Shell configurations
    └── nvim-config/       # Neovim submodule
```

## 🔧 Common Operations

### System Updates
```bash
# Update all dependencies
nix flake update

# Rebuild system
sudo darwin-rebuild switch --flake .#mini

# Test without applying
darwin-rebuild build --flake .#mini
```

### Submodule Management
```bash
# Update submodules to latest
git submodule update --remote

# After submodule changes
nix flake update
```

### Configuration Changes
```bash
# Edit main config
vim flake.nix

# Edit CLI tools (in submodule)
cd cli-config && vim packages/

# Apply changes
sudo darwin-rebuild switch --flake .#mini
```

## 🎨 Customization

### Adding New CLI Tools
1. Create new `.nix` file in `cli-config/packages/`
2. Add to `cli-config/packages/default.nix`
3. Commit and push to cli-config repository
4. Run `nix flake update` in main repository

### Shell Customization
- **Prompt**: Edit `cli-config/themes/oh-my-posh/theme.json`
- **Aliases**: Edit `cli-config/shells/aliases.nix`
- **Zsh config**: Edit `cli-config/packages/zsh.nix`

### System Apps
- **Homebrew casks**: Edit `flake.nix` casks section
- **System packages**: Edit `flake.nix` environment.systemPackages

## 🛠️ Requirements

- **macOS**: Apple Silicon or Intel Mac
- **Nix**: Multi-user installation with flakes enabled
- **Git**: For submodule management

### Initial Setup
```bash
# Install Nix (if not already installed)
curl -L https://nixos.org/nix/install | sh

# Enable flakes (add to ~/.config/nix/nix.conf)
experimental-features = nix-command flakes
```

## 🏷️ Target System

- **Platform**: aarch64-darwin (Apple Silicon)
- **User**: andreszambrano
- **Configuration**: "mini"

## 📚 Documentation

- **Development Guide**: See `CLAUDE.md` for detailed technical documentation
- **CLI Config**: Check `cli-config/README.md` for tool-specific details
- **Nix Darwin**: [Official Documentation](https://github.com/LnL7/nix-darwin)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes in appropriate submodules
4. Test with `darwin-rebuild build --flake .#mini`
5. Submit a pull request

## 📄 License

This configuration is provided as-is for personal use. Individual tools and packages retain their respective licenses.

---

*Declaratively managed with ❤️ using Nix*