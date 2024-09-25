{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 0;
        height = 30;

        modules-left = ["custom/logo" "custom/timer"];
        modules-center = ["hyprland/workspaces"];
        modules-right =
          if config.var.hostname == "laptop"
          then [
            "tray"
            "backlight"
            "pulseaudio"
            # "custom/caffeine"
            "custom/night-shift"
            "battery"
            "clock"
          ]
          else [
            "tray"
            "pulseaudio"
            # "custom/caffeine"
            "custom/night-shift"
            "custom/nix-updates"
            "clock"
          ];

        "custom/logo" = {
          format = "  ";
          tooltip = false;
          on-click = "appmenu";
        };

        "custom/timer" = {
          "tooltip" = true;
          "return-type" = "json";
          "interval" = 1;
          "exec" = "timer check";
          "on-click" = "timer minute_dialog";
          "on-click-right" = "timer datetime_dialog";
          "on-click-middle" = "timer stop";
        };

        "hyprland/workspaces" = {
          "on-click" = "activate";
          format = "{icon}";
          "format-icons" = {
            "default" = "";
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "active" = "󱓻";
            "urgent" = "󱓻";
          };
          "persistent-workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        tray = {spacing = 16;};

        backlight = {
          device = "intel_backlight";
          format = "{icon}";
          "format-icons" = [" " " " "" "" "" "" "" "" ""];
        };

        pulseaudio = {
          format = "{icon}";
          "format-bluetooth" = "󰂰";
          nospacing = 1;
          "tooltip-format" = "Volume : {volume}%";
          "format-muted" = "󰝟";
          "format-icons" = {
            "headphone" = "";
            "default" = ["󰖀" "󰕾" ""];
          };
          "on-click" = "sound-toggle";
          "scroll-step" = 1;
        };

        # "custom/caffeine" = {
        #   format = "{}";
        #   "return-type" = "json";
        #   max-length = 5;
        #   interval = 10;
        #   exec = "caffeine-status-icon";
        #   "on-click" = "caffeine";
        # };

        "custom/night-shift" = {
          format = "{}";
          "return-type" = "json";
          max-length = 5;
          interval = 10;
          exec = "night-shift-status-icon";
          "on-click" = "night-shift";
        };

        "custom/nix-updates" = {
          "exec" = "update-check";
          "on-click" = "update-check && ${pkgs.libnotify}/bin/notify-send 'The system has been updated'";
          "interval" = 3600;
          "tooltip" = true;
          "return-type" = "json";
          "format" = "{}  {icon}";
          "format-icons" = {
            "has-updates" = "";
            "updated" = "";
          };
        };

        battery = {
          format = "{capacity}% {icon}";
          "format-icons" = {
            "charging" = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            "default" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          "format-full" = "󰁹 ";
          interval = 10;
          states = {
            warning = 20;
            critical = 10;
          };
          tooltip = false;
        };

        clock = {
          format = "󰥔  {:%I:%M %p}";
          "format-alt" = "  {:%a, %d %b %Y}";
          "tooltip-format" = "<tt>{calendar}</tt>";
          "calendar" = {
            "mode" = "month";
            "mode-mon-col" = 3;
            "on-scroll" = 1;
            "on-click-right" = "mode";
            "format" = {
              "months" = "<span color='#${config.var.theme.colors.text}'><b>{}</b></span>";
              "weekdays" = "<span color='#${config.var.theme.colors.accent}'><b>{}</b></span>";
              "today" = "<span color='#${config.var.theme.colors.accent}'><b>{}</b></span>";
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
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: "${config.var.theme.font.base}";
        color: #${config.var.theme.colors.text};
        font-weight: 700;
      }

      window#waybar {
        background-color: rgba(0, 0, 0, 0);
        transition-property: background-color;
        transition-duration: 0.5s;
        border-radius: 15px;
        font-size: 15px;
      }

      .modules-left, .modules-center, .modules-right {
        border-radius: 15px;
        background-color: #${config.var.theme.colors.background};
        padding: 0px;
        margin-top: 5px;
        margin-bottom: 5px;
      }

      .modules-left {
        margin-left:5px;
      }

      .modules-right {
        margin-right:5px;
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      #workspaces {
        background-color: transparent;
      }

      #workspaces button {
        all: initial; /* Remove GTK theme values (waybar #1351) */
        min-width: 0; /* Fix weird spacing in materia (waybar #450) */
        box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
        padding: 2px 13px;
        margin: 3px;
        border-radius: 9px;
        background-color: #${config.var.theme.colors.background_alternative};
        color: #${config.var.theme.colors.text};
        transition: all 0.3s ease-in-out;
      }

      #workspaces button.active {
        color: #${config.var.theme.colors.background};
        background-color: #${config.var.theme.colors.accent};
      }

      #workspaces button:hover {
       box-shadow: inherit;
       text-shadow: inherit;
       opacity: 0.8;
      }

      #workspaces button.urgent {
        background-color: #f38ba8;
      }

      #window > * {
        font-family: "${config.var.theme.font.mono}";
      }

      #memory,
      #custom-caffeine,
      #custom-logo,
      #custom-timer,
      #custom-night-shift,
      #custom-nix-updates,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #tray,
      #backlight{
        border-radius: 9px;
        margin: 3px;
        padding: 8px 12px;
        background-color: #${config.var.theme.colors.background_alternative};
        color: #${config.var.theme.colors.text};
      }

      #tray menu {
        background-color: #${config.var.theme.colors.background_alternative};
        color: #${config.var.theme.colors.text};
      }

      #custom-logo {
        font-size: 15px;
        color: #${config.var.theme.colors.accent};
        padding: 2px 6px;
      }

      #custom-caffeine.active,
      #custom-night-shift.active,
      #custom-nix-updates.active,
      #custom-timer.active {
       color: #${config.var.theme.colors.accent};
      }

      #battery.warning,
      #battery.critical,
      #battery.urgent {
        background-color: #ff0048;
        color: #181825;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }

      #battery.charging {
        background-color: #${config.var.theme.colors.background_alternative};
        color: #${config.var.theme.colors.text};
        animation: none;
      }

      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #${config.var.theme.colors.background_alternative};
        color: #${config.var.theme.colors.text};
      }

      tooltip label {
        padding: 5px;
        background-color: #${config.var.theme.colors.background_alternative};
        color: #${config.var.theme.colors.text};
      }
    '';
  };
}
