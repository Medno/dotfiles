return {
  -- Allow to select containers
  { "echasnovski/mini.ai", version = "*" },
  { "echasnovski/mini.icons", version = "*" },
  -- Open and close brackets, quotes
  {
    "echasnovski/mini.pairs",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup({})
    end,
  },
}
