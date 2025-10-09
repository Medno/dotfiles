return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  ft = "python",
  config = function()
    require("venv-selector").setup()
  end,
  keys = {
    { ",v", "<cmd>VenvSelect<cr>" },
  },
  opts = {     -- this can be an empty lua table - just showing below for clarity.
    search = {}, -- if you add your own searches, they go here.
    options = {} -- if you add plugin options, they go here.
  },
}
