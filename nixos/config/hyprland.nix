# This is a module for all Hyprland-related configuration

{ pkgs, ... }:

{
  # 1. Add all necessary packages for the Hyprland environment
  home.packages = [
    # Hyprland and friends
    pkgs.hyprland
    pkgs.hyprpaper  # or swww
    pkgs.waybar
    pkgs.wofi
    pkgs.mako       # notification daemon
    pkgs.kitty      # terminal
    pkgs.grim       # for screenshots
    pkgs.slurp      # for screenshots
    pkgs.swaylock   # for screen locking

    # Essential utilities
    pkgs.polkit_gnome # for authentication dialogs
    pkgs.networkmanagerapplet
    pkgs.pavucontrol
  ];
  
  # 2. Enable the Hyprland Wayland compositor
  wayland.windowManager.hyprland = {
    enable = true;
    # You can also use a config file, but extraConfig is more declarative
    extraConfig = ''
      # This is where your hyprland.conf contents go
      # For a full example, see the previous response or Hyprland's wiki
      
      # Set monitor resolution
      monitor=,preferred,auto,1

      gestures {
        workspace_swipe = false
      }

      # Launch programs on startup
      exec-once = waybar &
      exec-once = swww init &
      exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

      # Set programs you use
      $terminal = ghostty
      $menu = wofi --show drun

      # Your keybinds, window rules, and other settings go here...
      $mainMod = SUPER
      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, R, exec, $menu
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, B, togglesplit, # dwindle
      bind = $mainMod, F, pseudo, # dwindle

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5

      # Requires playerctl
      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      # Fix some dragging issues with XWayland
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
      
    '';
  };

  # 3. Configure companion programs
  programs.waybar.enable = true;
  services.mako = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 14;
    };
  };
  
  # 4. Set necessary environment variables for a Wayland session
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1"; # Hint for Electron apps to use Wayland
  };
}
