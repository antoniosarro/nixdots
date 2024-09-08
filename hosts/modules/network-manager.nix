{config, ...}: {
  networking = {
    networkmanager.enable = true;
    hostName = config.var.hostname;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
