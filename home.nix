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
    notion-app
    discord
    spotify
    whatsapp-for-mac
    texlive.combined.scheme-full
    claude-code
    raycast
    nerd-fonts.fira-code
  ];

  # Fonts
  fonts.fontconfig.enable = true;

  # Kitty terminal configuration
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 14;
    };
    settings = {
      background_opacity = "0.95";
      window_padding_width = 8;
    };
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
