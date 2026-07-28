{ pkgs, user, ... }:

{
  nixpkgs = {
    hostPlatform = user.system;
    config.allowUnfree = true;
  };

  system.primaryUser = user.username;

  users.users.${user.username} = {
    home = "/Users/${user.username}";
    shell = pkgs.zsh;
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    optimise.automatic = true;

    gc = {
      automatic = true;
      interval = {
        Weekday = 7;
        Hour = 3;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
  ];

  # A small, development-focused subset of macOS preferences. No security,
  # privacy, login, MDM, firewall, or administrative policy is managed here.
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };

    dock = {
      autohide = true;
      show-recents = false;
      tilesize = 41;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };

    CustomUserPreferences."com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
  };

  # First use of nix-darwin on this configuration.
  system.stateVersion = 7;
}
