{config, ...}: {
  networking = {
    networkmanager.enable = true;
    networking.hostName = config.var.hostname;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
