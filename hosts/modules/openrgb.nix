{
  pkgs,
  lib,
  ...
}: {
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
    package = pkgs.openrgb-with-all-plugins;
  };
  boot.kernelModules = ["i2c-dev" "i2c-piix"];
  services.udev.packages = [pkgs.openrgb];
  # systemd.services.openrgb = {
  #   wantedBy = ["multi-user.target"];
  #   after = ["network.target"];
  #   description = lib.mkForce "Start the openrgb service on startup.";
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = lib.mkForce ''
  #       ${pkgs.openrgb}/bin/openrgb \
  #         --color "ed3511" \
  #         --mode "static"
  #     '';
  #   };
  # };
}
