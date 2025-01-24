return {
  "vyfor/cord.nvim",
  branch = "client-server",
  build = ":Cord update",
  opts = {
    editor = {
      tooltip = "I use Neovim (and NixOS) btw",
    },
    timestamp = {
      reset_on_idle = true,
    },
  },
}
