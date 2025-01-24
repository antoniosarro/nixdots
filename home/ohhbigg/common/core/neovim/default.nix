{
  pkgs,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
  };

  home.packages = with pkgs; [
    # Build Tools
    gcc
    gnumake

    # Fzf
    ripgrep

    # Lua
    lua-language-server
    stylua

    # Svelte / Typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.svelte-language-server
    nodePackages_latest.prettier
    eslint_d

    # Json / Yaml SchemaStore
    vscode-langservers-extracted
    yaml-language-server
  ];

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixdots/home/ohhbigg/common/core/neovim/nvim";
}
