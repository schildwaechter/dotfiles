return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    sync_install = false,
    ignore_install = { "javascript" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    auto_install = true,
    ensure_installed = {
      "bash",
      "c",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "hcl",
      "helm",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "luap",
      "query",
      "regex",
      "rust",
      "terraform",
      "vim",
      "vimdoc",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>vv",
        node_incremental = "+",
        scope_incremental = false,
        node_decremental = "_",
      },
    },
  },
  -- config = function()
  --     -- In nvim-treesitter 1.0+, highlight and indent are auto-enabled
  --     -- No setup() call needed for basic functionality
  --
  --     -- Enable folding
  --     vim.opt.foldmethod = "expr"
  --     vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  --     vim.opt.foldlevel = 99 -- Start with all folds open
  -- end,
}
