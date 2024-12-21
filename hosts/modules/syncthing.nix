{config, ...}: {
  services = {
    syncthing = {
      enable = true;
      user = "ohhbigg";
      dataDir = config.var.homeDirectory + "/Syncthing";
      configDir = config.var.homeDirectory + "/.config/syncthing";
      settings.gui = {
        user = "ohhbigg";
        password = "Montefalc!one!99";
      };
    };
  };
}
