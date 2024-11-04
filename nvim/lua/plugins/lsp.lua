return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{                                     -- optional completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
	-- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },    -- Required
			{ "williamboman/mason.nvim" },  -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "j-hui/fidget.nvim",                opts = {} },
		},
		config = function()
			local lsp = require("lsp-zero").preset({})

			lsp.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp.default_keymaps({ buffer = bufnr })
			end)

			require("lspconfig").pyright.setup({
				on_attach = function(client, bufnr)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
						{ buffer = bufnr, desc = "Go to Implementation" })
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Help" })
					-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Symbol References" })
					-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
						{ buffer = bufnr, desc = "Go to Next Diagnostic" })
					vim.keymap.set("n", "gl", vim.diagnostic.open_float,
						{ buffer = bufnr, desc = "Open Diagnostic Float" })
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
						{ buffer = bufnr, desc = "Go to Previous Diagnostic" })
					-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Diagnostic to local list" })
				end,
				settings = {
					pyright = {
						reportMissingImports = true,
						typeCheckingMode = "off",
					},
				},
			})

			lsp.setup()
		end,
	},
	-- Preview definition, references
	{
		"rmagatti/goto-preview",
		event = "BufEnter",
		config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
	},
	-- LSP outline
	{ "stevearc/aerial.nvim", config = true },
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts) require 'lsp_signature'.setup(opts) end
	}
}
