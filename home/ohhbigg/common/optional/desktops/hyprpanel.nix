{ inputs, pkgs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {

    # Enable the module.
    # Default: false
    enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Import a theme from './themes/*.json'.
    # Default: ""
    theme = "catppuccin_macchiato";

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [
            "dashboard"
            "workspaces"
            "windowtitle"
            "media"
          ];
          middle = [ "clock" ];
          right = [
            "systray"
            "volume"
            "hyprsunset"
            "network"
            "bluetooth"
            "notifications"
          ];
        };
      };
    };

    # Configure and theme almost all options from the GUI.
    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      bar.customModules = {
        hyprsunset = {
          temperature = "3500k";
        };
      };

      menus.clock = {
        time = {
          military = false;
          hideSeconds = false;
        };
        weather = {
          enabled = true;
          unit = "metric";
          interval = 60000;
          location = "Montefalcione";
        };
      };

      theme.bar.transparent = true;

      theme.font = {
        name = "SFProDisplay Nerd Font";
        size = "1rem";
      };
    };
  };
}
