# dotfiles

Reproducible development environment using Nix + home-manager.

## Contents

- **nvim/** - Neovim configuration (lazy.nvim, LSP, treesitter, custom SQL workflow)
- **zellij/** - Zellij terminal multiplexer config and layouts
- **ghostty/** - Ghostty terminal emulator config
- **zsh/** - Zsh shell configuration

## Quick Start (Nix)

```bash
# 1. Install Nix (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# 2. Clone this repo
git clone https://github.com/jamesneb/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Apply the configuration
nix run home-manager -- switch --flake .#jamescomputer
```

That's it. All packages are installed and configs are symlinked.

## Updating

```bash
cd ~/dotfiles

# Update flake inputs (nixpkgs, home-manager)
nix flake update

# Apply changes
home-manager switch --flake .#jamescomputer
```

## Configuration Variants

```bash
# Apple Silicon Mac (default)
home-manager switch --flake .#jamescomputer

# Intel Mac
home-manager switch --flake .#jamescomputer-intel

# Linux
home-manager switch --flake .#jamescomputer-linux
```

## What Gets Installed

### Packages
- **Editors**: neovim
- **Terminal**: zellij, ghostty (manual install)
- **Shell**: zsh, starship, zoxide, fzf
- **CLI Tools**: ripgrep, fd, bat, eza, jq, yq, lazygit, gh
- **Languages**: Node.js, Rust (rustup), Go, Python
- **LSP/Formatters**: lua-language-server, typescript-language-server, prettier, stylua
- **Database**: mysql-client, postgresql
- **Fonts**: Meslo Nerd Font, JetBrains Mono Nerd Font

### Configs Symlinked
- `~/.config/nvim` → `dotfiles/nvim`
- `~/.config/zellij` → `dotfiles/zellij`
- `~/.zshrc` → `dotfiles/zsh/zshrc`
- Ghostty config (platform-specific path)

## Manual Installation (without Nix)

If you don't want to use Nix:

```bash
./install.sh
```

This creates symlinks but you'll need to install packages yourself.

## Zellij Plugins

Zellij plugins (`.wasm` files) are not included in git. Download them:

- [zjstatus](https://github.com/dj95/zjstatus/releases) - Custom status bar
- [room](https://github.com/rvcas/room/releases) - Session management
- [monocle](https://github.com/imsnif/monocle/releases) - Fuzzy finder
- [harpoon](https://github.com/Nacho114/harpoon/releases) - Quick navigation
- [zellij-forgot](https://github.com/karimould/zellij-forgot/releases) - Command cheatsheet

Place them in `~/.config/zellij/plugins/`.

## Customization

### Adding packages
Edit `home.nix` and add to `home.packages`:

```nix
home.packages = with pkgs; [
  # ... existing packages
  your-new-package
];
```

### Changing username/paths
Update `home.nix`:

```nix
home.username = "yourusername";
home.homeDirectory = "/Users/yourusername";  # or /home/yourusername on Linux
```

And update `flake.nix` configuration names to match.

## Structure

```
dotfiles/
├── flake.nix          # Nix flake definition
├── home.nix           # Home Manager configuration
├── install.sh         # Non-Nix install script
├── nvim/              # Neovim config (native lua)
│   ├── init.lua
│   ├── lua/
│   └── after/
├── zellij/            # Zellij config (native kdl)
│   ├── config.kdl
│   └── layouts/
├── ghostty/           # Ghostty config
│   └── config
└── zsh/               # Zsh configs
    ├── zshrc
    ├── zprofile
    └── zshenv
```
