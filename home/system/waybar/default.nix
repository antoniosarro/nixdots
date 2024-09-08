{config, ...}: {
  services = {
    blueman-applet.enable = true;
    network-manager-applet.enable = true;
  };
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        spacing = 0;
        "margin-top" = 4;
        "margin-left" = 8;
        "margin-right" = 8;
        "margin-bottom" = 4;
        height = 36;
        modules-left = ["custom/logo"];
        modules-center = ["clock"];
        modules-right = [
          "tray"
          "backlight"
          "pulseaudio"
          "custom/night-shift"
          "battery"
        ];

        "custom/logo" = {
          format = "  ";
          tooltip = false;
          on-click = "appmenu";
        };
        clock = {
          "tooltip-format" = "<tt>{calendar}</tt>";
          "format-alt" = "  {:%a, %d %b %Y}";
          format = "󰥔  {:%I:%M %p}";
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
      }
      {
        layer = "top";
        position = "bottom";
        spacing = 0;
        "margin-top" = 8;
        "margin-left" = 8;
        "margin-right" = 8;
        "margin-bottom" = 8;
        height = 36;
        modules-center = ["hyprland/workspaces"];

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
      }
    ];
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

      #custom-logo {
        font-size: ${toString config.var.theme.waybar.font-size}px;
        color: #${config.var.theme.colors.accent};
      }

      #clock,
      #tray,
      #backlight,
      #pulseaudio,
      #custom-night-shift,
      #battery{
        border-radius: 9px;
        background-color: #ffffff;
        color: #FF0000;
        padding: 0 8px;
        margin: 0 4px;
      }

      #tray menu {
        background-color: #${config.var.theme.colors.bgalt};
        color: #${config.var.theme.colors.fgalt};
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
    '';
  };
}
