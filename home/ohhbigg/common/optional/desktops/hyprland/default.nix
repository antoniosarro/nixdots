{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./binds.nix # Hyprland binds

    ./hyprpaper.nix
    ./hyprlock.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      grimblast # screenshot
      brightnessctl # brightness
      wl-clipboard # system clipboard
      ;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = [ "--all" ];
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    settings = {
      # ============================
      # Environment Vars
      # ============================
      env = [
        "XDG_SESSION_TYPE,wayland"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_RENDERER_ALLOW_SOFTWARE,1"
        "QT_QPA_PLATFORM,wayland"
        "HYPRCURSOR_THEME,Bibata-Modern-Amber"

        # for ozone-based and electron apps on wayland
        "NIXOS_OZONE_WL, 1"

        # firefox on wayland
        "MOZ_ENABLE_WAYLAND, 1"
        "MOZ_WEBRENDER, 1"
      ];

      # ============================
      # Monitors
      # ============================
      monitor = (
        map (
          m:
          "${m.name},${
            if m.enabled then
              "${toString m.width}x${toString m.height}@${toString m.refreshRate},${toString m.x}x${toString m.y},1,transform,${toString m.transform},vrr,${toString m.vrr}"
            else
              "disable"
          }"
        ) (config.monitors)
      );

      # ============================
      # Behavior
      # ============================
      binds = {
        workspace_center_on = 1;
        movefocus_cycles_fullscreen = false;
      };
      input = {
        kb_layout = config.hostSpec.keyboardLayout;
        follow_mouse = 1;
        mouse_refocus = true;
      };
      cursor = {
        inactive_timeout = 10;
      };
      misc = {
        disable_hyprland_logo = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
      };

      # ============================
      # Appearance
      # ============================
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        "col.active_border" = "rgb(${config.hostSpec.theme.colors.base0D})";
        "col.inactive_border" = "rgb(${config.hostSpec.theme.colors.base03})";

        resize_on_border = true;
        hover_icon_on_border = true;
        allow_tearing = true;
      };
      decoration = {
        rounding = 10;
        inactive_opacity = 0.95;
        blur = {
          enabled = false;
          size = 6;
          passes = 3;
          popups = true;
        };
        shadow = {
          enabled = true;
          range = 12;
          offset = "3 3";
        };
      };

      # ============================
      # Auto Launch
      # ============================
      exec-once = [
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];

      # ============================
      # Layer Rules
      # ============================
      layer = { };

      # ============================
      # Window Rules
      # ============================
      windowrule = [
        # Dialogs
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(Accounts)(.*)$"
      ];
      windowrulev2 = [
        # Always Opaque

        # Remove transparency from video
        "opaque, title:^(Netflix)(.*)$"
        "opaque, title:^(.*YouTube.*)$"
        "opaque, title:^(Picture-in-Picture)$"

        # Steam rules
        "stayfocused, title:^()$,class:^([Ss]team)$"
        "minsize 1 1, title:^()$,class:^([Ss]team)$"
        "immediate, class:^([Ss]team_app_*)$"

        # Workspace Assignments
      ];
    };
  };
}
