return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "bash",
          "css",
          "diff",
          "dockerfile",
          "git_config",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "gowork",
          "gosum",
          "helm",
          "html",
          "javascript",
          "json",
          --"latex",
          "lua",
          "make",
          "markdown_inline",
          "markdown",
          "puppet",
          "python",
          "regex",
          "sql",
          "terraform",
          "toml",
          "vim",
          "vimdoc",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Enter>",
            node_incremental = "<Enter>",
            scope_incremental = false,
            node_decremental = "<Backspace>",
          },
        },
      })
    end,
  },
}
