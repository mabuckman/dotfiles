{ config, pkgs, ... }:  # This header is required

let
  secrets = import ../secrets.nix;
in
{
  home.username = "matt";
  home.homeDirectory = "/home/matt";
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    htop
    signal-desktop
    spotify
    obsidian
    ghostty
    protonmail-desktop
    vscodium
    vlc
    plexamp
    vesktop
    obs-studio
    mpv
    python3
    neovim
    # tmux
    gnumake
    lazygit
    btop
    ddcutil
    chatterino2
    rustup
    home-manager
    yt-dlp
    helvum
    ledger-live-desktop
    docker
    streamlink
    appimage-run
    python313Packages.powerline
    openssl
    outils
    atuin
    opencode
    qgis
    wl-clipboard
    vim
    wget
    ungoogled-chromium
    google-chrome
    gnome-tweaks
    niv
    git
    gcc
    nodejs_24
    unzip
    ripgrep 
    steam
    # Fonts
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.sauce-code-pro
  ];

  fonts.fontconfig.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  #programs.steam = {
    #enable = true;
    #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  #};

  programs.tmux = {
    enable = true;
    # Set your desired tmux prefix key (e.g., Ctrl+a)
    # prefix = "C-a";
    # Or use the 'shortcut' option for just the key without 'C-'
    # shortcut = "a";

    # Enable mouse support
    # mouse = true;

    # Set key bindings to vi mode
    keyMode = "vi";

    # Set the default terminal
    terminal = "screen-256color"; # or "tmux-256color"

    # Increase history limit
    historyLimit = 10000;

    # Use 24-hour clock
    clock24 = false;

    # Set escape time (milliseconds)
    escapeTime = 10; # Reduces delay for escape sequences


    # Manage tmux plugins
    plugins = with pkgs.tmuxPlugins; [
      sensible # Provides sensible default settings
      yank     # For copying to system clipboard
      # Add other plugins here, e.g.:
      # vim-tmux-navigator
      # cpu
      catppuccin
    ];

    # Automatically renumber windows when one is closed
    # This needs to be in extraConfig as there isn't a direct option
    extraConfig = ''
      # Global extraConfig settings
      set-option -g renumber-windows on
      # ... other global settings ...

      # Configuration for tmux-catppuccin
      set -g @catppuccin_flavour 'mocha' # latte, frappe, macchiato, or mocha

      # Source the catppuccin plugin script
      # The exact path might vary slightly based on the package structure,
      # but it's typically like this:
      run-shell "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux"
    '';

    # If a plugin requires specific configuration or order,
    # you might need to add to extraConfig and ensure plugins are sourced correctly.
    # For example, some plugins might need to be run after custom config:
    # extraConfig = ''
    #   # Custom status bar example before a plugin that modifies it
    #   set -g status-right "#[fg=black,bg=color15] #{cpu_percentage} %H:%M "
    #   run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
    # '';
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      v = "nvim";
    };
    bashrcExtra = ''
      if [ -f ${pkgs.powerline}/share/bash/powerline.sh ]; then
        source ${pkgs.powerline}/share/bash/powerline.sh
      fi
      eval "$(atuin init bash)"
    '';
  };

  programs.git = {
    enable = true;
    # Replace these placeholders with your actual info.
    userName = "mabuckman";
    userEmail = "matt@buckman.dev";

    extraConfig = {
      core.editor = "nvim";
    };
  };

  home.sessionVariables = {
    ANTHROPIC_API_KEY = secrets.antropicApiKey;
  };


# services.crontab = {
  #enable = true;
  #jobs = {
    # You give the job a descriptive name, e.g., "bedtime_routine"
    #"bedtime_routine" = {
    #  command = "/home/matt/scripts/bedtime_routine.sh";
    #  special = "45 20 * * *";
    #};
    # You could add other jobs here
    # "another_job" = { ... };
  #};
#};

}
