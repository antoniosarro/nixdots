{config, ...}: {
  imports = [../modules/variables-config.nix];

  config.var = {
    hostname = "desktop";
    username = "ohhbigg";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = config.var.homeDirectory + "/.config/nixdots";

    keyboardLayout = "us";

    timeZone = "Europe/Rome";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "en_US.UTF-8";

    git = {
      username = "antoniosarro";
      email = "tech@antoniosarro.dev";
    };

    autoUpgrade = false;
    autoGarbageCollector = false;

    sops = true;

    usbguard = false;
    usbguardRules = "";

    theme = import ../themes/ohhbigg.nix;
  };
}
