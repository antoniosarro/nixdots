{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>jk";
        mode = "i";
        action = "<ESC>";
        options.desc = "Exit insert mode with joking";
      }
      {
        key = "<leader>nh";
        mode = "n";
        action = ":nohl<CR>";
        options.desc = "Clear search highlights";
      }
      {
        key = "<leader>sv";
        mode = "n";
        action = "<C-w>v";
        options.desc = "Split window vertically";
      }
      {
        key = "<leader>sh";
        mode = "n";
        action = "<C-w>s";
        options.desc = "Split window horizontally";
      }
      {
        key = "<leader>se";
        mode = "n";
        action = "<C-w>=";
        options.desc = "Make splits equal size";
      }
      {
        key = "<leader>sx";
        mode = "n";
        action = "<cmd>close<CR>";
        options.desc = "Close current split";
      }
      {
        key = "<leader>to";
        mode = "n";
        action = "<cmd>tabnew<CR>";
        options.desc = "Open new tab";
      }
      {
        key = "<leader>tx";
        mode = "n";
        action = "<cmd>tabclose<CR>";
        options.desc = "Close current tab";
      }
      {
        key = "<leader>tn";
        mode = "n";
        action = "<cmd>tabn<CR>";
        options.desc = "Go to next tab";
      }
      {
        key = "<leader>tp";
        mode = "n";
        action = "<cmd>tabp<CR>";
        options.desc = "Go to previous tab";
      }
      {
        key = "<leader>tf";
        mode = "n";
        action = "<cmd>tabnew %<CR>";
        options.desc = "Open current buffer in new tab";
      }
    ];
  };
}
