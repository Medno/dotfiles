return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- use edgy's selection window
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        get_selection_window = function()
          require("edgy").goto_main()
          return 0
        end,
      },
    },
  },

  -- prevent neo-tree from opening files in edgy windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
          or { "terminal", "Trouble", "qf", "Outline", "trouble" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },
  -- Fix bufferline offsets when edgy is loaded
  {
    "akinsho/bufferline.nvim",
    optional = true,
  },
}
