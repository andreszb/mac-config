{
  pkgs,
  ...
}: {
  imports = [
    ./packages
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andreszambrano";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    betterdisplay
    the-unarchiver
    notion-app
    discord
    spotify
    firefox
    whatsapp-for-mac
    raycast
    anki-bin
  ];



  # Suppress login messages
  home.file.".hushlogin".text = "";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
