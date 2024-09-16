{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "presence.nvim";
        version = "87c857a";
        src = pkgs.fetchFromGitHub {
          owner = "andweeb";
          repo = "presence.nvim";
          rev = "87c857a";
          hash = "sha256-ZpsunLsn//zYgUtmAm5FqKVueVd/Pa1r55ZDqxCimBk=";
        };
      })
    ];
    extraConfigLua = ''
      require('presence').setup({
          neovim_image_text   = "I use Neovim (and NixOS, BTW)",
          main_image          = "file",
      })
    '';
  };
}
