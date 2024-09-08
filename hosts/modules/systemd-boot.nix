{pkgs, ...}: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      tmp.cleanOnBoot = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
