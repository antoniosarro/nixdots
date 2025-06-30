{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/nas/media/games" = {
    device = "//10.10.30.30/games";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,rw,uid=1000,gid=100" ];
  };
  fileSystems."/mnt/nas/important/configs" = {
    device = "//10.10.30.30/configs";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=/etc/nixos/smb-secrets,rw,uid=1000,gid=100" ];
  };
}
