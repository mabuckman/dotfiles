{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "network" "cpu" "memory" "temperature" "clock" "tray" "custom/power" ];

        # Left modules
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}: {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };

        # Center modules
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
        };

        # Right modules
        "tray" = {
          spacing = 10;
        };

        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "cpu" = {
          format = "{usage}% ";
          tooltip = false;
        };

        "memory" = {
          format = "{}% ";
        };

        "temperature" = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };



        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "wofi --show dmenu --width 200 --height 160 --no-actions --hide-scroll --matching=contains --insensitive=false --parse-search=false --allow_markup=false --prompt='' <<< $'Shutdown\nRestart\nLogout\nSleep' | xargs -I {} sh -c 'case {} in Shutdown) systemctl poweroff ;; Restart) systemctl reboot ;; Logout) hyprctl dispatch exit ;; Sleep) systemctl suspend ;; esac'";
        };
      };
    };

    style = ''
      * {
        font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 13px;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.9);
        border-bottom: 2px solid rgba(137, 180, 250, 0.8);
        color: #cdd6f4;
        transition-property: background-color;
        transition-duration: .5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }

      button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.active {
        background-color: rgba(137, 180, 250, 0.3);
        box-shadow: inset 0 -2px #89b4fa;
      }

      #workspaces button.focused {
        background-color: rgba(137, 180, 250, 0.3);
        box-shadow: inset 0 -2px #89b4fa;
      }

      #workspaces button.visible {
        background-color: rgba(137, 180, 250, 0.3);
        box-shadow: inset 0 -2px #89b4fa;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #mode {
        background-color: #64727D;
        border-bottom: 3px solid #ffffff;
      }

      #clock,

      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #mpd {
        padding: 0 10px;
        color: #ffffff;
      }

      #window,
      #workspaces {
        margin: 0 4px;
      }

      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #clock,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #temperature,
      #tray,
      #custom-power {
        background-color: rgba(49, 50, 68, 0.8);
        color: #cdd6f4;
        border-radius: 8px;
        margin: 2px;
        padding: 0 12px;
      }

      #network.disconnected {
        background-color: rgba(243, 139, 168, 0.8);
        color: #1e1e2e;
      }

      #pulseaudio.muted {
        background-color: rgba(88, 91, 112, 0.8);
        color: #6c7086;
      }

      #temperature.critical {
        background-color: rgba(243, 139, 168, 0.8);
        color: #1e1e2e;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      #idle_inhibitor {
        background-color: #2d3436;
      }

      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
      }

      #mpd {
        background-color: #66cc99;
        color: #2a5c45;
      }

      #mpd.disconnected {
        background-color: #f53c3c;
      }

      #mpd.stopped {
        background-color: #90b1b1;
      }

      #mpd.paused {
        background-color: #51a37a;
      }

      #language {
        background: #00b093;
        color: #740864;
        padding: 0 5px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state > label {
        padding: 0 5px;
      }

      #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad {
        background: rgba(0, 0, 0, 0.2);
      }

      #scratchpad.empty {
        background-color: transparent;
      }
    '';
  };
}