{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andreszambrano";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05";

  # User packages
  home.packages = with pkgs; [
    neovim
    kitty
    notion-app
    discord
    spotify
    whatsapp-for-mac
    texlive.combined.scheme-full
    nodejs_24
    claude-code
    nerd-fonts.fira-code
  ];

  # Fonts
  fonts.fontconfig.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Andres Zambrano";
    userEmail = "andreszb@me.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      pull.rebase = true;
      core.editor = "nvim";
      merge.tool = "vimdiff";
    };
    
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      cam = "commit -am";
      lg = "log --oneline --graph --decorate";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
