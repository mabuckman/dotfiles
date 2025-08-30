# This is a module for all Hyprland-related configuration

{ pkgs, ... }:

{
  imports = [
    ./waybar.nix
  ];
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

  # XDG Desktop Portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      hyprland = {
        default = [ "hyprland" "gtk" ];
      };
    };
  };
  
  # 2. Enable the Hyprland Wayland compositor
  wayland.windowManager.hyprland = {
    enable = true;
    # You can also use a config file, but extraConfig is more declarative
    extraConfig = ''
      # This is where your hyprland.conf contents go
      # For a full example, see the previous response or Hyprland's wiki
      
      # Set monitor resolution
      monitor=,preferred,auto,1

      # Cursor theme
      env = XCURSOR_THEME,Vanilla-DMZ
      env = XCURSOR_SIZE,24
      
      # Theme environment variables
      env = GTK_THEME,Adwaita:dark
      env = QT_STYLE_OVERRIDE,adwaita-dark
      
      cursor {
        no_hardware_cursors = false
      }

      gestures {
        workspace_swipe = false
      }

      input {
        scroll_factor = 0.5
      }

      general {
        # other general settings...
        layout = dwindle
      }

      dwindle {
        pseudotile = yes
        preserve_split = yes
        force_split = 2
      }

      animations {
        enabled = yes
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 0, 6, default  # Disabled workspace animations
      }

      dwindle {
        pseudotile = yes
        preserve_split = yes
        force_split = 2
      }

      # Launch programs on startup
      exec-once = waybar &
      exec-once = swww init &
      exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

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
      bind = $mainMod, T, togglesplit

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

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

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
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    style = ''
      window {
        margin: 0px;
        border: 2px solid #89b4fa;
        background-color: rgba(30, 30, 46, 0.95);
        border-radius: 12px;
      }

      #input {
        margin: 5px;
        border: 2px solid rgba(49, 50, 68, 0.8);
        color: #cdd6f4;
        background-color: rgba(49, 50, 68, 0.8);
        border-radius: 8px;
        padding: 8px;
        font-size: 14px;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #cdd6f4;
        font-size: 13px;
      }

      #entry {
        border: none;
        border-radius: 8px;
        margin: 2px;
        padding: 8px;
        background-color: transparent;
      }

      #entry:selected {
        background-color: rgba(137, 180, 250, 0.3);
        border: 2px solid #89b4fa;
      }

      #entry:hover {
        background-color: rgba(49, 50, 68, 0.5);
      }

      #img {
        margin-right: 8px;
      }
    '';
  };
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
    XCURSOR_THEME = "Vanilla-DMZ";
    XCURSOR_SIZE = "24";
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
}
