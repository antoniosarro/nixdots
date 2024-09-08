{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./variables.nix

    # Programs
    ../../home/programs/btop
    ../../home/programs/fetch
    ../../home/programs/git
    ../../home/programs/kitty
    ../../home/programs/nextcloud
    ../../home/programs/shell

    # Scripts

    # System
    ../../home/system/dunst
    ../../home/system/gtk
    ../../home/system/hyprland
    ../../home/sysetm/mime
    ../../home/system/rofi
    ../../home/system/waybar

    ./secrets
  ];

  home = {
    packages = with pkgs; [
      firefox
    ];

    file."wallpapers" = {
      recursive = true;
      source = ../../home/wallpapers;
    };

    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
