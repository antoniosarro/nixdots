{
  pkgs,
  config,
  ...
}: {
  # USB Automounting
  services.udisks2.enable = true;

  # USB Guard
  services.usbguard = {
    enable = config.var.usbguard;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    rules = config.var.usbguardRules;
  };

  # USB-specific packages
  environment.systemPackages = with pkgs; [usbutils];
}
