{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.epson-escpr];
  };

  # https://discourse.nixos.org/t/cups-cups-filters-and-libppd-security-issues/52780/2
  systemd.services.cups-browsed = {
    enable = false;
    unitConfig.Mask = true;
  };
}
