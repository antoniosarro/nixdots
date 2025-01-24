{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    # ============================
    # Main Key
    # ============================
    "$mainMod" = "SUPER";

    # ============================
    # Mouse Binds
    # ============================
    bindm = [
      "$mainMod,mouse:272,movewindow"
      "$mainMod,mouse:273,resizewindow"
    ];

    # ============================
    # Repeat Binds
    # ============================
    binde = [
      # Resize active window 30 pixels in direction
      "$mainMod SHIFT, right, resizeactive, 30 0"
      "$mainMod SHIFT, left, resizeactive, -30 0"
      "$mainMod SHIFT, up, resizeactive, 0 -30"
      "$mainMod SHIFT, down, resizeactive, 0 30"

      # Audio
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

      # Brightness
      ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
    ];

    # ============================
    # One-Click Binds
    # ============================
    bind = let
      terminal = config.home.sessionVariables.TERM;
      editor = config.home.sessionVariables.EDITOR;
    in
      [
        # Power system
        "$mainMod, ESCAPE, exec, powermenu"
        "$mainMod, L, exec, ${pkgs.hyprlock}/bin/hyprlock"

        # Quick Launch
        "$mainMod,A,exec,appmenu"
        "$mainMod,S,exec,${pkgs.rofi}/bin/rofi -show ssh"
        "ALT,tab,exec,${pkgs.rofi}/bin/rofi -show window"

        "$mainMod,T,exec,${terminal}"
        "$mainMod,F,exec,thunar"

        # Screenshotting
        "CTRL_ALT,p,exec,${pkgs.grimblast}/bin/grimblast --notify --freeze copy area"
        ",Print,exec,${pkgs.grimblast}/bin/grimblast --notify --freeze copy area"

        # Audio
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Player
        ", XF86AudioPlay, exec, '${pkgs.playerctl}/bin/playerctl --ignore-player=firefox,chromium,brave play-pause'"
        ", XF86AudioNext, exec, '${pkgs.playerctl}/bin/playerctl --ignore-player=firefox,chromium,brave next'"
        ", XF86AudioPrev, exec, '${pkgs.playerctl}/bin/playerctl --ignore-player=firefox,chromium,brave previous'"

        # Close focused/active window
        "$mainMod,Q,killactive"

        # Fullscreen
        "ALT,RETURN,fullscreen"
        "$mainMod, W,togglefloating"
        "ALT, P, pin, active"

        # Scroll through workspaces with mouse
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Misc
        "SHIFTALT,r,exec,hyprctl reload" # reload the configuration file
      ]
      ++ (builtins.concatLists (builtins.genList (i: let
          ws = i + 1;
        in [
          "$mainMod, code:1${toString i}, workspace, ${toString ws}"
          "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          "$mainMod ALT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
        ])
        10));
  };
}
