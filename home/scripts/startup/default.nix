# File runned at startup by Hyprland
{pkgs, ...}: let
  startup = pkgs.writeShellScriptBin "startup" ''
    ${pkgs.waybar}/bin/waybar &

    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
  '';
in {home.packages = [startup];}
