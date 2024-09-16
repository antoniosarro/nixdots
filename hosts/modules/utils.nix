{
  pkgs,
  config,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = config.var.keyboardLayout;
      xkb.variant = "";
    };
    gnome.gnome-keyring.enable = true;

    libinput.enable = true;
    dbus.enable = true;
  };
  console.keyMap = config.var.keyboardLayout;

  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "nvim";
  };

  programs.dconf.enable = true;

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  environment.systemPackages = with pkgs; [
    # simple, fast and user-friendly alternative to find
    fd
    # set of command line tools that assist applications with a variety of desktop integration tasks
    xdg-utils
    # tool for retrieving files using HTTP, HTTPS, and FTP
    wget
    # command line tool for transferring files with URL syntax
    curl
    # Nix/NixOS package version diff tool
    nvd
  ];
}
