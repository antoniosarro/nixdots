{pkgs, ...}: {
  imports = [
    ./hyprland
    ./services/dunst.nix
    ./waybar.nix
    ./rofi.nix
    ./gtk-qt.nix
    ./gammastep.nix
  ];
}
