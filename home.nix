{
  config,
  pkgs,
  lib,
  ...
}: {
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
    firefox
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

  # Create symlinks in Applications folder for Spotlight integration
  home.activation.trampolineApps = lib.hm.dag.entryAfter ["writeBoundary"] ''
    toDir="$HOME/Applications/Home Manager Apps"

    $DRY_RUN_CMD rm -rf "$toDir"
    $DRY_RUN_CMD mkdir -p "$toDir"

    # Find all GUI apps installed via Home Manager
    for pkg in ${lib.concatStringsSep " " (map (pkg: "${pkg}") config.home.packages)}; do
      if [ -d "$pkg/Applications" ]; then
        for app in "$pkg/Applications"/*.app; do
          if [ -d "$app" ]; then
            $DRY_RUN_CMD ln -sf "$app" "$toDir/$(basename "$app")"
          fi
        done
      fi
    done

    # Also create symlinks in root /Applications if we have write access
    if [ -w "/Applications" ]; then
      rootDir="/Applications/Home Manager Apps"
      $DRY_RUN_CMD rm -rf "$rootDir" 2>/dev/null || true
      $DRY_RUN_CMD mkdir -p "$rootDir" 2>/dev/null || true
      for pkg in ${lib.concatStringsSep " " (map (pkg: "${pkg}") config.home.packages)}; do
        if [ -d "$pkg/Applications" ]; then
          for app in "$pkg/Applications"/*.app; do
            if [ -d "$app" ]; then
              $DRY_RUN_CMD ln -sf "$app" "$rootDir/$(basename "$app")" 2>/dev/null || true
            fi
          done
        fi
      done
    fi
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
