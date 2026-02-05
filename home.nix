{ config, pkgs, lib, ... }:

let
  # Dotfiles source directory
  dotfilesDir = ./.;
in
{
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "jamescomputer";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/jamescomputer" else "/home/jamescomputer";

  # Version - don't change after initial setup
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # ============================================================================
  # PACKAGES
  # ============================================================================

  home.packages = with pkgs; [
    # Core tools
    neovim
    zellij
    git
    lazygit
    gh  # GitHub CLI

    # Shell
    zsh
    starship
    zoxide
    fzf
    bat
    eza  # modern ls
    ripgrep
    fd
    jq
    yq

    # Development
    nodejs_22
    rustup
    go
    python3

    # Neovim dependencies
    tree-sitter
    lua-language-server
    nodePackages.typescript-language-server
    nodePackages.prettier
    stylua
    shellcheck

    # Database
    mysql-client
    postgresql

    # Fonts (Nerd Fonts)
    (nerdfonts.override { fonts = [ "Meslo" "JetBrainsMono" ]; })
  ];

  # ============================================================================
  # CONFIG FILES (symlinked from this repo)
  # ============================================================================

  # Neovim - link entire directory
  xdg.configFile."nvim".source = "${dotfilesDir}/nvim";

  # Zellij - link entire directory
  xdg.configFile."zellij".source = "${dotfilesDir}/zellij";

  # Ghostty (macOS uses different path)
  home.file = lib.mkMerge [
    # Zsh configs in home directory
    {
      ".zshrc".source = "${dotfilesDir}/zsh/zshrc";
      ".zprofile".source = "${dotfilesDir}/zsh/zprofile";
      ".zshenv".source = "${dotfilesDir}/zsh/zshenv";
    }

    # Ghostty - macOS path
    (lib.mkIf pkgs.stdenv.isDarwin {
      "Library/Application Support/com.mitchellh.ghostty/config".source = "${dotfilesDir}/ghostty/config";
    })

    # Ghostty - Linux path
    (lib.mkIf pkgs.stdenv.isLinux {
      ".config/ghostty/config".source = "${dotfilesDir}/ghostty/config";
    })
  ];

  # ============================================================================
  # PROGRAM CONFIGURATIONS (Nix-managed alternatives)
  # ============================================================================

  # Git (optional - can also use dotfiles)
  programs.git = {
    enable = true;
    userName = "James Nebeker";
    userEmail = "james@example.com";  # Update this
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Zoxide (smart cd)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # FZF
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # ============================================================================
  # SHELL
  # ============================================================================

  programs.zsh = {
    enable = true;
    # Don't let home-manager generate .zshrc - we use our own
    initExtra = "";
  };
}
