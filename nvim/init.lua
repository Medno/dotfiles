vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy-setup")
require("lazy").setup("plugins")
require("keymaps")
require("options")
