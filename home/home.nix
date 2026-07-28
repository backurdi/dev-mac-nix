{
  config,
  pkgs,
  user,
  ...
}:

{
  home = {
    username = user.username;
    homeDirectory = "/Users/${user.username}";
    stateVersion = "26.05";

    packages = with pkgs; [
      coreutils
      findutils
      gnugrep
      gnused
      gawk
      curl
      wget

      git-lfs
      jq
      ripgrep
      fd
      fzf
      bat
      eza
      zoxide
      shellcheck
      shfmt
      tree
      httpie
      yq-go
      lazygit
      glow
      just
      tmux
      entr

      nil
      nixfmt-rfc-style
      statix
      deadnix
    ];

    sessionVariables = {
      EDITOR = "cursor --wait";
      VISUAL = "cursor --wait";
      LANG = "en_US.UTF-8";
      NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.local/share/npm";
      BUN_INSTALL = "${config.home.homeDirectory}/.bun";
    };

    sessionPath = [
      "/opt/homebrew/opt/node@24/bin"
      "${config.home.homeDirectory}/.local/share/npm/bin"
      "${config.home.homeDirectory}/.bun/bin"
      "${config.home.homeDirectory}/.local/bin"
    ];

    file = {
      ".config/git/ignore".source = ../dotfiles/git/ignore;

      "Library/Application Support/Cursor/User/settings.json".source =
        ../dotfiles/cursor/settings.json;
      "Library/Application Support/Cursor/User/keybindings.json".source =
        ../dotfiles/cursor/keybindings.json;

      "Library/Application Support/com.mitchellh.ghostty/config".source =
        ../dotfiles/ghostty/config;
    };
  };

  xdg.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    delta = {
      enable = true;
      options.navigate = true;
    };

    settings = {
      user = {
        name = user.fullName;
        email = user.email;
      };
      init.defaultBranch = "main";
      fetch.prune = true;
      push.autoSetupRemote = true;
      rerere.enabled = true;
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 50000;
      save = 50000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "npm"
      ];
    };

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];

    shellAliases = {
      code = "cursor";
      g = "git";
      gst = "git status";
      ll = "eza -la --group-directories-first";
      cat = "bat";
    };
  };

  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    historyLimit = 100000;
    terminal = "screen-256color";
  };
}
