{pkgs, ...}: {
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 10000;
          on-timeout = pkgs.hyprlock + "/bin/hyprlock";
        }
        {
          timeout = 10000;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
