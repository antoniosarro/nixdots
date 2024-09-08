# File runned at startup by Hyprland
{pkgs, ...}: let
  startup = pkgs.writeShellScriptBin "startup" ''
    pkill waybar
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.waybar}/bin/dunst &
    ${pkgs.hypridle}/bin/hypridle &
    ${pkgs.hyprpaper}/bin/hyprpaper &

    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
  '';
in {home.packages = [startup];}
