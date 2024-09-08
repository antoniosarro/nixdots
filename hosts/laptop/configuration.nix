{config, ...}: {
  imports = [
    # modules
    ../modules/audio.nix
    ../modules/auto-upgrade.nix
    ../modules/bluetooth.nix
    ../modules/fonts.nix
    ../modules/graphics.nix
    ../modules/gvfs.nix
    ../modules/home-manager.nix
    ../modules/network-manager.nix
    ../modules/nix.nix
    ../modules/nvidia-blacklist.nix
    ../modules/power-profile.nix
    ../modules/printer.nix
    ../modules/swap.nix
    ../modules/systemd-boot.nix
    ../modules/timezone.nix
    ../modules/tuigreet.nix
    ../modules/usb.nix
    ../modules/users.nix
    ../modules/utils.nix
    ../modules/zsh.nix

    # hardware
    ./hardware-configuration.nix
    ./disko.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "24.05";
}
