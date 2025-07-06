{ pkgs, ... }: {
  # VS Code configuration
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-toolsai.jupyter
        github.github-vscode-theme
      ];
      userSettings = {
        "editor.formatOnSave" = true;
        "editor.fontSize" = 14;
        "editor.fontFamily" = "FiraCode Nerd Font";
        "editor.fontLigatures" = true;
        "workbench.colorTheme" = "GitHub Dark Default";
        
        # Security - Disable workspace trust features
        "security.workspace.trust.enabled" = false;
        "security.workspace.trust.startupPrompt" = "never";
        "security.workspace.trust.emptyWindow" = false;
        "security.workspace.trust.untrustedFiles" = "open";
        "security.workspace.trust.banner" = "never";
        
        # Disable file operation confirmation prompts
        "explorer.confirmDragAndDrop" = false;      # Moving/copying files via drag and drop
        "explorer.confirmDelete" = false;           # Deleting files to trash/permanently
        "explorer.confirmPasteNative" = false;      # Pasting files from system clipboard
      };
      keybindings = [
        {
          key = "ctrl+/";
          command = "workbench.action.terminal.toggleTerminal";
        }
      ];
    };
  };
}
