# persistence
Reload previous sessions
-- return {
--   {
--     "folke/persistence.nvim",
--     event = "BufReadPre", -- this will only start session saving when an actual file was opened
--     opts = {
--       -- add any custom options here
--     },
--   },
-- }

# Snippet
Automatize creation of code

return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
}
