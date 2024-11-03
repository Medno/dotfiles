vim.cmd [[colorscheme tokyonight]]

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Set options
vim.o.cursorline = true
vim.o.showcmd = true
vim.o.statusline = "%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
vim.o.laststatus = 2
vim.o.ruler = true
vim.o.mouse = 'a'
vim.o.backspace = 'indent,eol,start'

vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
-- vim.o.colorcolumn = '100'
vim.o.history = 100
vim.o.foldlevel = 99
vim.o.foldmethod = 'indent'
vim.o.autowriteall = true

-- Line numbering
vim.o.number = true
vim.o.relativenumber = true

-- Buffer split
vim.o.splitbelow = true
vim.o.splitright = true

-- Set encoding if multi-byte support is available
if vim.fn.has("multi_byte") == 1 then
	vim.o.encoding = 'utf-8'
	vim.g.fileencoding = 'utf-8'
else
	vim.cmd('echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"')
end

-- Set true color mode for Neovim if not in tmux
if vim.fn.empty(vim.fn.getenv("TMUX")) == 1 then
	if vim.fn.has("nvim") == 1 then
		vim.fn.setenv("NVIM_TUI_ENABLE_TRUE_COLOR", 1)
	end
	if vim.fn.has("termguicolors") == 1 then
		vim.o.termguicolors = true
	end
end

-- Map \ to :Rexplore<CR>
vim.api.nvim_set_keymap('n', '\\', ':Rexplore<CR>', { noremap = true, silent = true })

-- Highlight Pmenu with grey background
-- vim.api.nvim_set_hl(0, 'Pmenu', { ctermbg = 'gray', guibg = 'gray' })

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = ' ',
			[vim.diagnostic.severity.WARN] = ' ',
			[vim.diagnostic.severity.INFO] = ' ',
			[vim.diagnostic.severity.HINT] = '󰌵 ',
		}
	}
})

-- Custom configuration for LazyGit
vim.g.lazygit_use_custom_config_file_path = 1                            -- config file path is evaluated if this value is 1
local config_dir = vim.fn.expand("<sfile>:p:h")
vim.g.lazygit_config_file_path = config_dir .. '/lua/config/lazygit.yml' -- custom config file path
