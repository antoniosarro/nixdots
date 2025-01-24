{pkgs, ...}: {
  environment.systemPackages = [pkgs.lact];
  systemd.packages = with pkgs; [lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}
