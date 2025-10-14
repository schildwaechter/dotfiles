return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
      -- or select" (`vim.ui.select`).
      picker = "telescope",

      lsp = {
        -- `config` is passed to `vim.lsp.start(config)`
        config = {
          name = "zk",
          cmd = { "zk", "lsp" },
          filetypes = { "markdown" },
          -- on_attach = ...
          -- etc, see `:h vim.lsp.start()`
          vim.keymap.set("n", "<leader>zn", ":ZkNew<CR>", { desc = "[Z]K [N]ew" }),
          vim.keymap.set(
            "n",
            "<leader>zs",
            ":'<,'>ZkNewFromTitleSelection<CR>",
            { desc = "[Z]K new from [S]election" }
          ),
          vim.keymap.set("n", "<leader>zp", ":ZkNotes<CR>", { desc = "[Z]K notes [P]icker" }),
          vim.keymap.set("n", "<leader>zl", ":ZkLinks<CR>", { desc = "[Z]K [L]inks" }),
          vim.keymap.set("n", "<leader>zb", ":ZkBacklinks<CR>", { desc = "[Z]K [B]acklinks" }),
          vim.keymap.set("n", "<leader>zt", ":ZkTags<CR>", { desc = "[Z]K [T]ags" }),
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
        },
      },
    })
  end,
}
