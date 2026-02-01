return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  keys = {
    {
      "<leader>oa",
      function()
        require("opencode").ask()
      end,
    },
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ")
      end,
      mode = "v",
    },
  },
}
