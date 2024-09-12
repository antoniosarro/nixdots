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
    ../../home/programs/spicetify
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
      firefox
      freecad
      gnome-sound-recorder
      obsidian
      vlc
      vscodium

      # socials
      _64gram
      freetube
      teamspeak_client
      vesktop

      # utils
      android-file-transfer
      cpupower-gui
      localsend
      pandoc
      unzip
      zip
    ];

    file."wallpapers" = {
      recursive = true;
      source = ../../home/wallpapers;
    };

    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
