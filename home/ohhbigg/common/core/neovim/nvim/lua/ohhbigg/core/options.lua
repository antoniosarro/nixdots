vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- relative line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- colors
opt.cursorline = true

-- colors
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start";

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitbelow = true;
opt.splitright = true;

-- turn off swapfile
opt.swapfile = false