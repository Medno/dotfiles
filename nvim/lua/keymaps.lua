-- -- [[ Basic Keymaps ]]
local opts = { noremap = true, silent = true }
-- WINDOWS
-- ----------------------------------------------------------------------------------------
-- Navigating between open windows
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to window on the right", opts.args })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to window on the left", opts.args })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to window below", opts.args })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to window above", opts.args })

-- Neotree
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle neo-tree", opts.args })
vim.keymap.set("n", "<leader>E", "<cmd>Neotree toggle float<cr>", { desc = "Toggle neo-tree float", opts.args })

-- Spectre, S/R
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})
