return {
  { "echasnovski/mini.surround", version = "*" },
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
