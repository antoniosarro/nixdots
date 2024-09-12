{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hyprcursor.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
    # Screenshot
    grimblast
    swappy

    # Brightness
    brightnessctl

    # Nightshift
    wlsunset

    # Polkit
    polkit_gnome
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    settings = {
      monitor =
        if config.var.hostname == "desktop"
        then [",3440x1440@120,auto,1"]
        else if config.var.hostname == "laptop"
        then [",preferred,auto,1"]
        else "";

      exec-once = [
        "startup"
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"

        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"

        "HYPRCURSOR_THEME,Bibata-Modern-Amber"
        "HYPRCURSOR_SIZE,20"
      ];

      input = {
        kb_layout = config.var.keyboardLayout;
        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0;
        force_no_accel = 1;
      };

      general = {
        gaps_in = config.var.theme.gaps-in;
        gaps_out = config.var.theme.gaps-out;
        border_size = config.var.theme.border-size;
        "col.active_border" = "rgba(${config.var.theme.colors.accent}ff)";
        "col.inactive_border" = "rgba(00000055)";
        layout = "dwindle";
        resize_on_border = true;
      };

      decoration = {
        rounding = config.var.theme.rounding;
        drop_shadow = false;

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # layerrule = "blur,waybar";

      windowrulev2 = "noblur, title:^()$, class:^()$ ";

      misc = {
        vrr = 0;
        force_default_wallpaper = 0;
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      "$mainMod" = "SUPER";

      bind =
        [
          # Window/Session actions
          "$mainMod, Q, killactive" # kill active window
          "ALT, F4, killactive" # kill active window
          "$mainMod, delete, exit" # kill hyperland session
          "$mainMod, W, togglefloating" # toggle the window on focus to float
          "$mainMod, G, togglegroup" # toggle the window on focus to float
          "ALT, return, fullscreen" # toggle the window on focus to fullscreen
          "$mainMod, backspace, exec, powermenu" # logout menu
          "$CONTROL, ESCAPE, exec, pkill waybar || ${pkgs.waybar}/bin/waybar" # toggle waybar

          # Application shortcuts
          "$mainMod, T, exec, ${pkgs.kitty}/bin/kitty" # open terminal

          # Rofi launcher controls
          "$mainMod, A, exec, appmenu" # open desktop app launcher
          "$mainMod, ESCAPE, exec, powermenu" # open power menu
          ",Print, exec, screenshot" # open screenshot menu

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "ALT, Tab, movefocus, d"

          # Switch workspaces relative to the active workspace with mainMod + CTRL + [←→]
          "$mainMod CTRL, right, workspace, r+1"
          "$mainMod CTRL, left, workspace, r-1"

          # move to the first empty workspace instantly with mainMod + CTRL + [↓]
          "$mainMod CTRL, down, workspace, empty "

          # Resize windows
          "$mainMod SHIFT, right, resizeactive, 30 0"
          "$mainMod SHIFT, left, resizeactive, -30 0"
          "$mainMod SHIFT, up, resizeactive, 0 -30"
          "$mainMod SHIFT, down, resizeactive, 0 30"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ]
        ++ (builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            # Switch workspaces with mainMod + [0-9]
            "$mainMod, code:1${toString i}, workspace, ${toString ws}"

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"

            # Move window silently to workspace Super + Alt + [0-9]
            "$mainMod ALT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
          ])
          10));

      bindm = [
        "$mainMod, mouse:272, movewindow" # Move Window (mouse)
        "$mainMod, R, resizewindow" # Resize Window (mouse)
      ];

      bindl = [
        ",XF86AudioMute, exec, sound-toggle" # Toggle Mute
      ];

      bindle = [
        ", XF86AudioRaiseVolume, exec, sound-up" # Sound Up
        ", XF86AudioLowerVolume, exec, sound-down" # Sound Down
        ", XF86MonBrightnessUp, exec, brightness-up" # Brightness Up
        ", XF86MonBrightnessDown, exec, brightness-down" # Brightness Down
      ];
    };
  };
}
