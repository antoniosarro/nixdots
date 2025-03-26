{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./hyprpanel.nix
    ./rofi.nix
    ./gtk-qt.nix
  ];
}
