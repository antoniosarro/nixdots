{
  programs.nixvim.colorschemes = {
    base16 = {
      enable = true;
      setUpBar = false;
      colorscheme = import ../../colors.nix {};
    };
  };
}
