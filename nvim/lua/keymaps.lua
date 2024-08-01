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


vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
vim.keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
vim.keymap.set("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
vim.keymap.set("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })