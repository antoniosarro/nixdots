{config, ...}: {
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      storageDriver = "overlay2";
      liveRestore = true;
      daemon.settings = {
        default-address-pools = [
          {
            base = "172.17.0.0/12";
            size = 20;
          }
        ];
        ip = "127.0.0.1";
      };
    };
    oci-containers.backend = "docker";

    virtualisation.oci-containers.containers."watchtower" = {
      autoStart = true;
      image = "docker.io/containrrr/watchtower";
      volumes = ["/var/run/docker.sock:/var/run/docker.sock"];
      environment = {
        TZ = "Europe/Rome";
        WATCHTOWER_CLEANUP = "true";
        WATCHTOWER_NO_RESTART = "true";
        # Run every day at 6:00 EDT
        WATCHTOWER_SCHEDULE = "0 0 3 * * *";
      };
    };
  };

  users.users."${config.var.username}".extraGroups = ["docker"];
}
