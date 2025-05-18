return {
  "cuducos/yaml.nvim",
  ft = { "yaml" }, -- optional
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    vim.keymap.set("n", "<leader>ys", ":YAMLTelescope<CR>", { noremap = true, desc = "YAML search" })
    -- vim.keymap.set("n", "<leader>yv", ":YAMLView<CR>", { noremap = true, desc="YAML view" })
    vim.keymap.set("n", "<leader>yy", ":YAMLYank +<CR>", { noremap = true, desc = "YAML yank" })
  end,
}
