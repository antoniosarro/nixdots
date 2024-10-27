{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Command line tool for configuring any YubiKey over all USB transports
    yubikey-manager
    # Yubico Authenticator for Desktop
    yubioath-flutter
    # PAM module for allowing authentication with a U2F device
    pam_u2f
  ];

  services = {
    pcscd.enable = true;
    udev.packages = [pkgs.yubikey-personalization];
    yubikey-agent.enable = true;
  };

  security = {
    pam = {
      sshAgentAuth.enable = true;
      u2f = {
        enable = true;
        settings = {
          cue = false;
          authFile = "${config.homeDirectory}/.config/Yubico/u2f_keys";
        };
      };
      services = {
        login.u2fAuth = true;
        sudo = {
          u2fAuth = true;
          sshAgentAuth = true;
        };
      };
    };
  };
}
