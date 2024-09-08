{config, ...}: {
  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = config.var.theme.waybar.position;
        position = config.var.theme.waybar.position;
        spacing = 0;

        "margin-top" =
          if
            config.var.theme.waybar.float
            && config.var.theme.waybar.position == "top"
          then config.var.theme.gaps-out
          else 0;
        "margin-left" =
          if config.var.theme.waybar.float
          then config.var.theme.gaps-out
          else 0;
        "margin-right" =
          if config.var.theme.waybar.float
          then config.var.theme.gaps-out
          else 0;

        height = 44;

        modules-left = ["custom/logo" "hyprland/window"];
        modules-center = ["hyprland/workspaces"];
        modules-right = [
          "tray"
          "backlight"
          "pulseaudio"
          "custom/caffeine"
          "custom/night-shift"
          "battery"
          "clock"
        ];

        "custom/logo" = {
          format = "  ";
          tooltip = false;
          on-click = "appmenu";
        };

        "hyprland/window" = {
          "format" = "{title:30}";
          "max-length" = 30;
          "separate-outputs" = true;
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

        "custom/caffeine" = {
          format = "{}";
          max-length = 5;
          interval = 10;
          exec = "caffeine-status-icon";
          "on-click" = "caffeine";
        };

        "custom/night-shift" = {
          format = "{}";
          max-length = 5;
          interval = 10;
          exec = "night-shift-status-icon";
          "on-click" = "night-shift";
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
              "months" = "<span color='#${config.var.theme.colors.fg}'><b>{}</b></span>";
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
        font-family: "${config.var.theme.font}";
        color: #${config.var.theme.colors.fg};
        font-weight: 700;
      }

      window#waybar {
        background-color: ${
        if config.var.theme.waybar.transparent
        then "rgba(0, 0, 0, 0)"
        else "#${config.var.theme.colors.bg}"
      };
        transition-property: background-color;
        transition-duration: 0.5s;
        border-radius: ${
        if config.var.theme.waybar.float
        then toString config.var.theme.rounding
        else "0"
      }px;
        font-size: ${toString config.var.theme.waybar.font-size}px;
      }

      .modules-left, .modules-center, .modules-right {
        border-radius: ${
        if config.var.theme.waybar.float
        then toString config.var.theme.rounding
        else "0"
      }px;
        background-color: #${config.var.theme.colors.bg};
        padding: 2px 6px;
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
        padding: 6px 18px;
        margin: 6px 3px;
        border-radius: 4px;
        background-color: #${config.var.theme.colors.bgalt};
        color: #${config.var.theme.colors.fgalt};
      }

      #workspaces button.active {
        color: #${config.var.theme.colors.accentFg};
        background-color: #${config.var.theme.colors.accent};
      }

      #workspaces button:hover {
       box-shadow: inherit;
       text-shadow: inherit;
       opacity: 0.8;
      }

      #workspaces button.urgent {
        background-color: #${config.var.theme.colors.c1};
      }

      #window > * {
        font-family: "${config.var.theme.font-mono}";
      }

      #memory,
      #custom-power,
      #custom-caffeine,
      #custom-night-shift,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #tray,
      #backlight{
        border-radius: 9px;
        margin: 6px 3px;
        padding: 6px 12px;
        background-color: #${config.var.theme.colors.bgalt};
        color: #${config.var.theme.colors.fgalt};
      }

      #tray menu {
        background-color: #${config.var.theme.colors.bgalt};
        color: #${config.var.theme.colors.fgalt};
      }

      #custom-logo {
        padding-right: 7px;
        font-size: ${toString config.var.theme.waybar.font-size}px;
        color: #${config.var.theme.colors.accent};
      }

      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
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

      #battery.charging {
        background-color: #${config.var.theme.colors.bgalt};
        color: #${config.var.theme.colors.fgalt};
        animation: none;
      }

      #custom-power {
        background-color: #${config.var.theme.colors.accent};
        color: #${config.var.theme.colors.accentFg};
      }


      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: #${config.var.theme.colors.bgalt};
        color: #${config.var.theme.colors.fgalt};
      }

      tooltip label {
        padding: 5px;
        background-color: #${config.var.theme.colors.bgalt};
        color: #${config.var.theme.colors.fgalt};
      }
    '';
  };
}
