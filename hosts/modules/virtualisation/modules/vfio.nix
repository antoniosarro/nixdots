{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.virtualisation.vfio;
in {
  options.virtualisation.vfio = {
    enable = mkEnableOption "VFIO Configuration";
    devices = mkOption {
      type = types.listOf (types.strMatching "[0-9a-f]{4}:[0-9a-f]{4}");
      default = [];
      example = ["10de:1b80" "10de:10f0"];
      description = "PCI IDs of devices to bind to vfio-pci";
    };
    ignoreMSRs = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "When true, disable kvm guest access to model-specific registers";
    };
    disablePCIeASPM = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "When true, disable PCIe Active-State Power Management";
    };
  };

  config = lib.mkIf cfg.enable {
    services.udev.extraRules = ''
      SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
    '';

    boot.kernelParams =
      ["amd_iommu=on"]
      ++ (optional (builtins.length cfg.devices > 0)
        ("vfio-pci.ids=" + builtins.concatStringsSep "," cfg.devices))
      ++ (optionals cfg.ignoreMSRs [
        "kvm.ignore_msrs=1"
        "kvm.report_ignored_msrs=0"
      ])
      ++ (optionals cfg.disablePCIeASPM [
        "pcie_aspm=off"
      ]);

    boot.kernelModules = ["vfio_pci" "vfio" "vfio_iommu_type1"];

    boot.initrd.kernelModules = ["vfio_pci" "vfio_iommu_type1" "vfio"];
  };
}
