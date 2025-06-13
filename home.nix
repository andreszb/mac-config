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
    notion-app
    discord
    spotify
    whatsapp-for-mac
    texlive.combined.scheme-full
    claude-code
    nerd-fonts.fira-code
    fzf
    bat
    delta
    raycast
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

  # Shell configuration
  programs.zsh = {
    enable = true;
    shellAliases = {
      nvim = "nixCats";
    };
    initContent = ''
      # Directory comparison function with fzf and delta
      compare_dirs() {
        if [ $# -ne 2 ]; then
          echo "Usage: compare_dirs <dir1> <dir2>"
          echo "Compare two directories with interactive fuzzy selection and syntax-highlighted diffs"
          echo "Press Enter to open files in vim diff mode"
          return 1
        fi
        
        local dir1="$1"
        local dir2="$2"
        
        # Validate directories
        if [ ! -d "$dir1" ]; then
          echo "Error: Directory '$dir1' does not exist" >&2
          return 1
        fi
        
        if [ ! -d "$dir2" ]; then
          echo "Error: Directory '$dir2' does not exist" >&2
          return 1
        fi
        
        # Get list of differing files
        local diff_files
        diff_files=$(diff -rq "$dir1" "$dir2" 2>/dev/null | grep -E "^Files.*differ$" | sed "s/^Files \(.*\) and \(.*\) differ$/\1|\2/")
        
        if [ -z "$diff_files" ]; then
          echo "No differences found between directories"
          return 0
        fi
        
        echo "Found $(echo "$diff_files" | wc -l) differing files"
        
        # Use fzf with delta preview and vim diff action
        echo "$diff_files" | fzf \
          --preview 'file1=$(echo {} | cut -d"|" -f1); file2=$(echo {} | cut -d"|" -f2); delta "$file1" "$file2" 2>/dev/null || diff -u "$file1" "$file2" 2>/dev/null || echo "Preview not available"' \
          --preview-window=right:70% \
          --header="Press Enter to open in vim diff mode, Ctrl-C to exit" \
          --bind="enter:execute(file1=\$(echo {} | cut -d'|' -f1); file2=\$(echo {} | cut -d'|' -f2); nvim -d \"\$file1\" \"\$file2\")"
      }
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
