{
  config,
  pkgs,
  lib,
  ...
}: let
  monitor = lib.head (lib.filter (m: m.primary) config.monitors);
in {
  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
  systemd.user.services.waybar = {
    Unit.StartLimitBurst = 30;
  };
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      # ============================
      # Main Bar
      # ============================
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 5;
        height = 30;
        margin-top = 6;
        margin-left = 10;
        margin-bottom = 0;
        margin-right = 10;
        modules-left = ["custom/launcher" "gamemode" "hyprland/workspaces"];
        modules-center = [];
        modules-right =
          [
            "tray"
          ]
          ++ lib.optional (config.hostSpec.hostName == "laptop") "backlight"
          ++ [
            "pulseaudio"
            "network"
          ]
          ++ lib.optional (config.hostSpec.hostName == "laptop") "battery"
          ++ ["clock" "custom/power-menu"];

        # ============================
        # Module Left
        # ============================
        "custom/launcher" = {
          "format" = " <span color='#ce703b'> </span>";
          "on-click" = "rofi -show drun";
        };
        "cpu" = {
          "interval" = 10;
          "format" = "󰄧 {}%";
          "max-length" = 10;
          "on-click" = "";
        };
        "memory" = {
          "interval" = 30;
          "format" = " {}%";
          "format-alt" = " {used:0.1f}G";
          "max-length" = 10;
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "format-icons" = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "active" = "";
            "default" = "";
          };
        };

        # ============================
        # Module Center
        # ============================

        # ============================
        # Module Right
        # ============================
        "tray" = {
          "spacing" = 10;
        };
        "backlight" = {
          "device" = "${monitor.name}";
          "format" = "{icon} {percent}%";
          "format-icons" = ["" "" "" "" "" "" "" "" ""];
          "on-click" = "";
        };
        "pulseaudio" = {
          "format" = "{icon} {volume}%";
          "format-bluetooth" = "  {volume}%";
          "format-bluetooth-muted" = "󰟎 ";
          "format-muted" = "󰟎";
          "format-icons" = {
            "headphone" = "";
            "headset" = "󰋎";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
          };
          "on-click" = "pavucontrol";
        };
        "network" = {
          "format-wifi" = "󰖩 {signalStrength}%";
          "format-ethernet" = "󰈀 wired";
          "format-disconnected" = "󰖪";
          "on-click" = "bash ~/.config/waybar/scripts/rofi-wifi-menu.sh";
        };
        "battery" = {
          "bat" = "";
          "adapter" = "";
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "max-length" = 20;
          "format" = "{icon} {capacity}%";
          "format-warning" = "{icon} {capacity}%";
          "format-critical" = "{icon} {capacity}%";
          "format-charging" = "<span font-family='Font Awesome 6 Free'></span> {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-alt" = "{icon} {time}";
          "format-full" = "  {capacity}%";
          "format-icons" = [" " " " " " " " " "];
        };
        "gamemode" = {
          "format" = "{glyph}";
          "format-alt" = "{glyph} {count}";
          "glyph" = "󰊴";
          "hide-not-running" = true;
          "use-icon" = true;
          "icon-name" = "input-gaming-symbolic";
          "icon-spacing" = 4;
          "icon-size" = 20;
          "tooltip" = true;
          "tooltip-format" = "Games running: {count}";
        };
        "clock" = {
          "format" = "<span color='#bf616a'>  </span>{:%a, %b %d}";
          "format-alt" = "<span color='#bf616a'>  </span>{:%I:%M %p}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "mode" = "month";
            "mode-mon-col" = 3;
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#ffffff'><b>{}</b></span>";
              "weekdays" = "<span color='#bf616a'><b>{}</b></span>";
              "today" = "<span color='#bf616a'><b>{}</b></span>";
            };
          };
          "actions" = {
            "on-click-right" = "mode";
            "on-click-forward" = "tz_up";
            "on-click-backward" = "tz_down";
            "on-scroll-up" = "shift_up";
            "on-scroll-down" = "shift_down";
          };
        };
        "custom/power-menu" = {
          "format" = " <span color='#6a92d7'>⏻ </span>";
          "on-click" = "bash ~/.config/waybar/scripts/power-menu/powermenu.sh";
        };
      };
    };
    style = ''
      * {
          font-family: "${config.hostSpec.theme.font.base}";
          font-weight: 700;
          font-size: 16px;
      }

      window#waybar {
          background-color: rgba(26, 27, 38, 0.5);
          color: #ffffff;
          transition-property: background-color;
          transition-duration: 0.5s;
          border-top: 8px transparent;
          border-radius: 8px;
          transition-duration: 0.5s;
          margin: 16px 16px;
      }

      window#waybar.hidden {
           opacity: 0.2;
      }

      #workspaces button {
        padding: 0 5px;
        color: #7984A4;
        background-color: transparent;
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each workspace name */
        border: none;
        border-radius: 0;
      }

      #workspaces button.focused {
        color: #bf616a;
      }

      #workspaces button.active {
        color: #6a92d7;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }

      #window {
        /* border-radius: 20px; */
        /* padding-left: 10px; */
        /* padding-right: 10px; */
        color: #64727d;
      }

      #cpu,
      #memory,
      #tray,
      #backlight,
      #pulseaudio,
      #network,
      #battery,
      #gamemode,
      #clock,
      #custom-power-menu{
        padding: 0 10px;
        color: #e5e5e5;
        /* color: #bf616a; */
        border-radius: 9.5px;
        background-color: #1f2530;
      }


      #window,
      #workspaces {
        margin: 0 4px;
        border-radius: 7.8px;
        background-color: #1f2530;
      }

      #custom-launcher {
          background-color: #1b242b;
          color: #6a92d7;
          border-radius: 7.5px;
          padding: 0 3px;
      }

      #cpu {
        color: #fb958b;
        background-color: #1f2530;
      }

      #memory {
        color: #ebcb8b;
        background-color: #1f2530;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: #eb4d4b;
      }

      #backlight {
        color: #8fbcbb;
      }

      #pulseaudio {
        color: #7d9bba;
      }

      #network {
        color: #b48ead;
      }

      #network.disconnected {
        color: #f53c3c;
      }

      #battery {
        color: #c0caf5;
        /* background-color: #90b1b1; */
      }

      #battery.charging,
      #battery.full,
      #battery.plugged {
        color: #26a65b;
        /* background-color: #26a65b; */
      }

      @keyframes blink {
        to {
          background-color: rgba(30, 34, 42, 0.5);
          color: #abb2bf;
        }
      }

      #battery.critical:not(.charging) {
        color: #f53c3c;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #clock {
        color: #c8d2e0;
        /* background-color: #14141e; */
      }

      #custom-power-menu {
        border-radius: 9.5px;
        background-color: #1b242b;
        border-radius: 7.5px;
        padding: 0 5px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }
    '';
  };
}
