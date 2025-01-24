{
  pkgs,
  config,
  lib,
  ...
}: let
  monitor = lib.head (lib.filter (m: m.primary) config.monitors);

  steam-session = let
    gamescope = lib.concatStringsSep " " [
      (lib.getExe pkgs.gamescope)
      "--output-width ${toString monitor.width}"
      "--output-height ${toString monitor.height}"
      "--framerate-limit ${toString monitor.refreshRate}"
      "--prefer-output ${monitor.name}"
      "--adaptive-sync"
      "--expose-wayland"
      "--steam"
      "--hdr-enabled"
      "--mangoapp"
    ];
    steam = lib.concatStringsSep " " [
      "steam"
      #"steam://open/bigpicture"
    ];
  in
    pkgs.writeTextDir "share/applications/steam-session.desktop" ''
      [Desktop Entry]
      Name=Steam Session
      Exec=${gamescope} -- ${steam}
      Icon=steam
      Type=Application
    '';
in {
  imports = [
    ./minecraft.nix
  ];

  home.packages = [
    steam-session
  ];
}
