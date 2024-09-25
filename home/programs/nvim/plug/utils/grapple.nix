{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "grapple.nvim";
        version = "7aedc26";
        src = pkgs.fetchFromGitHub {
          owner = "cbochs";
          repo = "grapple.nvim";
          rev = "7aedc26";
          hash = "sha256-apWKHEhXjFdS8xnSX0PoiOMzR+RVuYHFLV9sUl/HhTE=";
        };
      })
    ];
    extraConfigLua = ''
      require('grapple').setup({
        scope = "git_branch",
      })
    '';
  };
}
