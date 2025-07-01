{
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
      cursor_trail = 3;
      hide_window_decorations = "titlebar-only";
    };
  };
}