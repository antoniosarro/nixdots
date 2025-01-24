############################################################################
#
#  Main Laptop
#  NixOS running on Intel I7 8565U, MX150, 16GB RAM
#
############################################################################
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    # ============================
    # Hardware
    # ============================
    ./hardware-configuration.nix
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    # ============================
    # Nvidia
    # ============================
    inputs.hardware.nixosModules.common-gpu-nvidia

    # ============================
    # Disk Layout
    # ============================
    inputs.disko.nixosModules.disko
    (lib.custom.relativeToRoot "hosts/common/disks/laptop.nix")

    (map lib.custom.relativeToRoot [
      # Required Configs
      "hosts/common/core"

      # Optional Configs
      "hosts/common/optional/services/greetd.nix" # display manager
      "hosts/common/optional/services/printing.nix" # CUPS
      "hosts/common/optional/audio.nix" # pipewire and cli controls
      "hosts/common/optional/bluetooth.nix" # bluetooth service
      "hosts/common/optional/gaming.nix" # steam, gamescope, gamemode, and related hardware
      "hosts/common/optional/hyprland.nix" # window manager
      "hosts/common/optional/obsidian.nix" # Notes
      "hosts/common/optional/plymouth.nix" # Animated boot screen
      "hosts/common/optional/scanning.nix" # SANE and simple-scan
      "hosts/common/optional/thunar.nix" # file manager
      "hosts/common/optional/vlc.nix" # media player
      "hosts/common/optional/wayland.nix" # wayland components and pkgs not available in home-manager
      "hosts/common/optional/virtualisation.nix" # Qemu & Docker
    ])
  ];

  # ============================
  # Nvidia
  # ============================
  hardware.nvidia.open = false;
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  specialisation."integrated-gpu".configuration = {
    imports = lib.flatten [
      inputs.hardware.nixosModules.common-gpu-nvidia-disable
    ];
  };

  # ============================
  # Host Specification
  # ============================
  hostSpec = {
    hostName = "laptop";
    keyboardLayout = "it";
    # useYubikey = lib.mkForce false;
    # hdr = lib.mkForce false;
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

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "24.11";
}
