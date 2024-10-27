{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./variables.nix

    # Programs
    ../../home/programs/btop
    ../../home/programs/fetch
    ../../home/programs/firefox
    ../../home/programs/git
    ../../home/programs/kitty
    ../../home/programs/nextcloud
    ../../home/programs/nvim
    ../../home/programs/shell
    ../../home/programs/spicetify
    ../../home/programs/vesktop
    ../../home/programs/zathura

    # Scripts
    ../../home/scripts

    # System
    ../../home/system/dunst
    ../../home/system/gtk
    ../../home/system/hyprland
    ../../home/system/mime
    ../../home/system/rofi
    ../../home/system/udiskie
    ../../home/system/waybar

    ./secrets
  ];

  home = {
    packages = with pkgs; [
      # file manager
      xfce.thunar

      # apps
      bitwarden
      cameractrls
      easyeffects
      freecad
      gnome-sound-recorder
      obsidian
      obs-studio
      mpv
      vscodium
      protonmail-desktop
      libreoffice
      dbeaver-bin

      # socials
      telegram-desktop
      freetube
      teamspeak_client
      streamlink
      element-desktop

      # utils
      android-file-transfer
      amdgpu_top
      cameractrls-gtk4
      cpupower-gui
      gawk
      localsend
      pandoc
      unzip
      zip

      # code
      alejandra # nix code formatter
    ];

    file."wallpapers" = {
      recursive = true;
      source = ../../home/wallpapers;
    };

    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
