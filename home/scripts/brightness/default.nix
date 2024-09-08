{pkgs, ...}: let
  increments = "5";

  brightness-change = pkgs.writeShellScriptBin "brightness-change" ''
    sleep 0.05

    [[ $1 == "up" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ${increments}%+
    [[ $1 == "down" ]] && ${pkgs.brightnessctl}/bin/brightnessctl set ${increments}%-

    current_brightness=$(${pkgs.brightnessctl}/bin/brightnessctl g)
    max_brightness=$(${pkgs.brightnessctl}/bin/brightnessctl m)

    brightness_level=$(( (current_brightness * 100) / max_brightness ))

    message="󰃠  Brightness: $brightness_level%"

    notif "brightness" "$message" "extraargs=-h int:value:$brightness_level"
  '';

  brightness-up = pkgs.writeShellScriptBin "brightness-up" ''
    brightness-change up ${increments}
  '';

  brightness-down = pkgs.writeShellScriptBin "brightness-down" ''
    brightness-change down ${increments}
  '';
in {home.packages = [brightness-change brightness-up brightness-down];}
