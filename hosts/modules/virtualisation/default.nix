{config, pkgs, ...}: {
  imports = [
    ./modules/vfio.nix
    ./modules/libvirt.nix
    ./modules/virtualisation.nix
    ./modules/kvmfr-options.nix
  ];

  virtualisation = {
    # docker
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

    # libvirtd
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [pkgs.OVMFFull.fd];
        };
      };
      clearEmulationCapabilities = false;
      deviceACL = [
        "/dev/ptmx"
        "/dev/kvm"
        "/dev/kvmfr0"
        "/dev/vfio/vfio"
        "/dev/vfio/30"
      ];
    };

    # KVM FrameRelay for Looking Glass
    kvmfr = {
      enable = true;
      shm = {
        enable = true;
        size = 128;
        user = "${config.var.username}";
        group = "qemu-libvirtd";
        mode = "0666";
      };
    };
    # USB redirection in virtual machine
    spiceUSBRedirection.enable = true;
  };

  specialisation."VFIO".configuration = {
    system.nixos.tags = ["with-vfio"];
    virtualisation.vfio = {
      enable = true;
      devices = [
        "1002:73df" # RX 6700XT Graphics
        "1002:ab28" # RX 6700XT Audio
      ];
      ignoreMSRs = true;
      disablePCIeASPM = true;
    };
  };

  # virt-manager
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    virt-manager
    docker-compose
    util-linux
  ];

  boot.kernelModules = ["kvm-amd" "vhost_vsock"];

  users.users."${config.var.username}".extraGroups = ["docker" "qemu-libvirtd" "libvirtd" "kvm"];
}
