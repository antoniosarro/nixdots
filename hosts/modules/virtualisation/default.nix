{
  config,
  pkgs,
  ...
}: let
  qemu_9_1_0 =
    import (pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "940d545355d5e79859502334f2fe269c3996046b";
      sha256 = "1klhr7mrfhrzcqfzngk268jspikbivkxg96x2wncjv1ik3zb8i75";
    }) {
      inherit (pkgs) system;
    };

  hugepage_handler = pkgs.writeShellScript "hugepage_handler" ''
    xml_file="/var/lib/libvirt/qemu/$1.xml"

    function extract_number() {
      local xml_file=$1
      local number=$(grep -oPm1 "(?<=<memory unit='KiB'>)[^<]+" $xml_file)
      echo $((number/1024))
    }

    function prepare() {
      # Calculate number of hugepages to allocate from memory (in MB)
      HUGEPAGES="$(($1/$(($(grep Hugepagesize /proc/meminfo | ${pkgs.gawk}/bin/gawk '{print $2}')/1024))))"

      echo "Allocating hugepages..."
      echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
      ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)

      TRIES=0
      while (( $ALLOC_PAGES != $HUGEPAGES && $TRIES < 1000 ))
      do
          echo 1 > /proc/sys/vm/compact_memory
          ## defrag ram
          echo $HUGEPAGES > /proc/sys/vm/nr_hugepages
          ALLOC_PAGES=$(cat /proc/sys/vm/nr_hugepages)
          echo "Successfully allocated $ALLOC_PAGES / $HUGEPAGES"
          let TRIES+=1
      done

      if [ "$ALLOC_PAGES" -ne "$HUGEPAGES" ]
      then
          echo "Not able to allocate all hugepages. Reverting..."
          echo 0 > /proc/sys/vm/nr_hugepages
          exit 1
      fi
    }

    function release() {
      echo 0 > /proc/sys/vm/nr_hugepages
    }

    case $2 in
      prepare)
          number=$(extract_number $xml_file)
          prepare $number
          ;;
      release)
          release
          ;;
    esac
  '';
  cpu_pinning = pkgs.writeShellScript "cpu_pinning" ''
    if [[ $1 == "win11" ]]; then
      if [[ $2 == "started" ]]; then
        # CPU isolation
        systemctl set-property --runtime -- user.slice AllowedCPUs=0,1,6,7
        systemctl set-property --runtime -- system.slice AllowedCPUs=0,1,6,7
        systemctl set-property --runtime -- init.scope AllowedCPUs=0,1,6,7
      fi
      if [[ $2 == "stopped" ]]; then
        # Free all CPUs
        systemctl set-property --runtime -- user.slice AllowedCPUs=0-11
        systemctl set-property --runtime -- system.slice AllowedCPUs=0-11
        systemctl set-property --runtime -- init.scope AllowedCPUs=0-11
      fi
    fi
  '';
in {
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
    oci-containers = {
      backend = "docker";
      containers."watchtower" = {
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
      containers."portainer" = {
        autoStart = true;
        image = "docker.io/portainer/portainer-ce";
        volumes = ["/var/run/docker.sock:/var/run/docker.sock" "portainer_data:/data"];
        ports = ["8000:8000" "9443:9443"];
      };
      containers."postgres" = {
        autoStart = true;
        image = "docker.io/postgres";
        volumes = ["postgres_data:/var/lib/postgresql/data"];
        ports = ["5432:5432"];
        environment = {
          TZ = "Europe/Rome";
          POSTGRES_PASSWORD = "root";
        };
      };
    };

    # libvirtd
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        package = qemu_9_1_0.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [qemu_9_1_0.OVMFFull.fd];
        };
      };
      hooks.qemu = {
        hugepages_handler = "${hugepage_handler}";
        cpu_pinning = "${cpu_pinning}";
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
    looking-glass-client
    remmina
    virt-manager
    docker-compose
    util-linux
  ];

  boot.kernelModules = ["kvm-amd" "vhost_vsock"];

  users.users."${config.var.username}".extraGroups = ["docker" "qemu-libvirtd" "libvirtd" "kvm"];
}
