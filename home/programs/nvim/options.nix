{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    globals = {
      mapleader = " ";
    };
    performance = {
      byteCompileLua = {
        enable = true;
        nvimRuntime = true;
        configs = true;
        plugins = true;
      };
    };
    clipboard = {
      # use system clipboard
      register = "unnamedplus";

      providers = {
        wl-copy = {
          enable = true;
          package = pkgs.wl-clipboard;
        };
      };
    };
    opts = {
      # enable relative line numbers
      relativenumber = true;
      number = true;

      # set tabs to 2 spaces
      tabstop = 2;
      softtabstop = 2;
      showtabline = 2;
      expandtab = true;

      # enable auto indenting and set it to spaces
      smartindent = true;
      shiftwidth = 2;

      # enable smart indenting
      breakindent = true;

      # enable incremental searching
      hlsearch = true;
      incsearch = true;

      # enable text wrap
      wrap = true;

      # better splitting
      splitbelow = true;
      splitright = true;

      # enable mouse mode
      mouse = "a";

      # enable ignorecase + smartcase for better searching
      ignorecase = true;
      smartcase = true;
      grepprg = "rg --vimgrep";
      grepformat = "%f:%l:%c:%m";

      # decrease updatetime
      updatetime = 10; # faster completion (4000ms default)

      # set completeopt to have a better completion experience
      completeopt = [
        "menuone"
        "noselect"
        "noinsert"
      ]; # mostly just for cmp

      # enable persistent undo history
      swapfile = false;
      backup = false;
      undofile = true;

      # enable 24-bit colors
      termguicolors = true;

      # enable the sign column to prevent the screen from jumping
      signcolumn = "yes";

      # enable cursor line highlight
      cursorline = true;

      # set fold settings
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # always keep 8 lines above/below cursor unless at start/end of file
      scrolloff = 8;

      # place a column line
      # colorcolumn = "80";

      # set encoding type
      encoding = "utf-8";
      fileencoding = "utf-8";

      # more space in the neovim command line for displaying messages
      cmdheight = 0;
    };
  };
}
