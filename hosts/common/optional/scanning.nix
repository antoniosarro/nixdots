{pkgs, ...}: {
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.epson-escpr
      pkgs.sane-airscan
    ];
  };

  services.udev.packages = [pkgs.sane-airscan];
  services.ipp-usb.enable = true;

  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      simple-scan # GUI scanning application
      sane-frontends # Command-line scanning tools
      ;
  };
}
