############################################################################
#
#  Main Desktop
#  NixOS running on Ryzen 5 5600X, Radeon RX 6700 XT, 32GB RAM
#
############################################################################
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    # ============================
    # Hardware
    # ============================
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # ============================
    # Disk Layout
    # ============================
    inputs.disko.nixosModules.disko
    (lib.custom.relativeToRoot "hosts/common/disks/desktop.nix")

    (map lib.custom.relativeToRoot [
      # Required Configs
      "hosts/common/core"

      # Optional Configs
      "hosts/common/optional/amd.nix"
      "hosts/common/optional/services/greetd.nix" # display manager
      "hosts/common/optional/services/printing.nix" # CUPS
      "hosts/common/optional/audio.nix" # pipewire and cli controls
      "hosts/common/optional/bluetooth.nix" # bluetooth service
      "hosts/common/optional/gaming.nix" # steam, gamescope, gamemode, and related hardware
      "hosts/common/optional/gpu.nix"
      "hosts/common/optional/graphene.nix"
      "hosts/common/optional/hyprland.nix" # window manager
      "hosts/common/optional/kdeconnect.nix"
      "hosts/common/optional/obsidian.nix" # Notes
      "hosts/common/optional/plymouth.nix" # Animated boot screen
      "hosts/common/optional/protonvpn.nix" # vpn
      "hosts/common/optional/scanning.nix" # SANE and simple-scan
      "hosts/common/optional/thunar.nix" # file manager
      "hosts/common/optional/mpv.nix" # media player
      "hosts/common/optional/nix-ld.nix"
      "hosts/common/optional/obs.nix"
      "hosts/common/optional/wayland.nix" # wayland components and pkgs not available in home-manager
      "hosts/common/optional/virtualisation.nix" # Qemu & Docker
      "hosts/common/optional/flatpak.nix"
    ])
  ];

  # ============================
  # Host Specification
  # ============================
  hostSpec = {
    hostName = "desktop";
    keyboardLayout = "us";
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = lib.mkDefault 10;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.initrd = {
    systemd.enable = true;
  };

  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfff7ffff" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "24.11";
}
