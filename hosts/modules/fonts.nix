{
  pkgs,
  inputs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode"];})
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
      inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd
      noto-fonts-color-emoji
    ];

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono" "Noto Color Emoji"];
        sansSerif = ["SFProDisplay Nerd Font" "Noto Color Emoji"];
        serif = ["SFProDisplay Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
