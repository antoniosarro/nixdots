{
  pkgs,
  config,
  ...
}:
{
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
        experimental = true;
        insecure-registries = ["10.10.30.29:5000"];
        registry-mirrors = ["http://10.10.30.29:5000"];
      };
    };
    oci-containers = {
      backend = "docker";
      containers."watchtower" = {
        autoStart = true;
        image = "docker.io/containrrr/watchtower";
        volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
        environment = {
          TZ = "Europe/Rome";
          WATCHTOWER_CLEANUP = "true";
          WATCHTOWER_NO_RESTART = "true";
          # Run every day at 6:00 EDT
          WATCHTOWER_SCHEDULE = "0 0 3 * * *";
        };
      };
      containers."portainer" = {
        autoStart = true;
        image = "docker.io/portainer/portainer-ce";
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "portainer_data:/data"
        ];
        ports = [
          "8000:8000"
          "9443:9443"
        ];
      };
      containers."postgres" = {
        autoStart = true;
        image = "docker.io/postgres";
        volumes = [ "postgres_data:/var/lib/postgresql/data" ];
        ports = [ "5432:5432" ];
        environment = {
          TZ = "Europe/Rome";
          POSTGRES_PASSWORD = "root";
        };
      };
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    waydroid = {
      enable = true;
    };
  };

  programs.virt-manager.enable = true;
  environment.systemPackages = [
    pkgs.qemu_kvm
    pkgs.qemu
  ];
  users.users.${config.hostSpec.username} = {
    extraGroups = [ "libvirtd" ];
  };
}
