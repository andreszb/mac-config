{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    cli-config = {
      url = "github:andreszb/cli-config";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvim-config.url = "github:andreszb/nvim-config";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    mac-app-util,
    home-manager,
    cli-config,
  }: let
    configuration = {pkgs, ...}: {
      nixpkgs.config.allowUnfree = true;

      homebrew = {
        user = "andreszambrano";
        enable = true;
        onActivation = {
          autoUpdate = true;
          cleanup = "uninstall";
          upgrade = true;
        };

        brews = [
          "mas"
        ];
        casks = [
          "1password"
          "readdle-spark"
          "logi-options+"
          "ticktick"
          "zen"
          "tor-browser"
          "telegram"
          "1password-cli"
        ];
        masApps = {
          "1Password for Safari" = 1569813296;
          Xcode = 497799835;
          "HP Smart for Desktop" = 1474276998;
          "Speechify" = 1209815023;
        };
      };

      system.primaryUser = "andreszambrano";
      networking.computerName = "Mac de Nacho";
      networking.hostName = "MacMini";
      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "/Applications/Zen.app"
          "/System/Applications/Launchpad.app"
          "/Applications/Spark Desktop.app"
          "{pkgs.kitty}/Applications/kitty.app"
          "/Applications/TickTick.app"
        ];
        finder = {
          FXPreferredViewStyle = "clmv";
          AppleShowAllExtensions = true;
          _FXSortFoldersFirstOnDesktop = true;
          _FXSortFoldersFirst = true;
          _FXShowPosixPathInTitle = true;
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
          NewWindowTarget = "Home";
          QuitMenuItem = true;
          ShowPathbar = true;
          ShowRemovableMediaOnDesktop = true;
          ShowStatusBar = true;
        };
        LaunchServices.LSQuarantine = false;
        NSGlobalDomain = {
          InitialKeyRepeat = 15;
          KeyRepeat = 2;
          "com.apple.swipescrolldirection" = false;
          AppleInterfaceStyleSwitchesAutomatically = true;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          AppleInterfaceStyle = "Dark";
        };
      };
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "andreszambrano";
          };
        }
        mac-app-util.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.andreszambrano = {
            imports = [
              ./home.nix
              cli-config.homeManagerModules.default
              mac-app-util.homeManagerModules.default
            ];
            programs.cli-config = {
              enable = true;
              userConfig = {
                name = "Andres Zambrano";
                email = "andreszb@gmail.com";
                username = "andreszambrano";
              };
              nvim-config = cli-config.inputs.nvim-config;
            };
          };
          users.users.andreszambrano.home = "/Users/andreszambrano";
        }
      ];
    };
  };
}
